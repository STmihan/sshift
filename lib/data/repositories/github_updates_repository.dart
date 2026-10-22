import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/app_links.dart';
import '../../domain/models/app_update.dart';
import '../../domain/models/download_progress.dart';
import '../../domain/repositories/updates_repository.dart';
import '../mappers/github_release_mapper.dart';

class GithubUpdatesRepository implements UpdatesRepository {
  GithubUpdatesRepository({Future<Directory> Function()? downloadsDirectory})
    : _downloadsDirectory = downloadsDirectory ?? _defaultDownloadsDirectory;

  static const _headers = {
    'Accept': 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28',
  };
  static const _progressSteps = 200;
  static const _partialSuffix = '.part';

  final Future<Directory> Function() _downloadsDirectory;

  static Future<Directory> _defaultDownloadsDirectory() async {
    final temp = await getTemporaryDirectory();

    return Directory(p.join(temp.path, 'updates'));
  }

  static String _fileName(AppUpdate update) {
    return 'sshift-${update.version}.apk';
  }

  @override
  Future<AppUpdate?> fetchLatest() async {
    final response = await http.get(Uri.parse(githubLatestReleaseApiUrl), headers: _headers);

    if (response.statusCode == HttpStatus.notFound) {
      return null;
    }

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException('GitHub API responded with ${response.statusCode}');
    }

    return appUpdateFromGithubRelease(jsonDecode(response.body) as Map<String, Object?>);
  }

  @override
  Stream<DownloadProgress> downloadApk(AppUpdate update) {
    final client = http.Client();
    late final StreamController<DownloadProgress> controller;

    Future<void> download() async {
      try {
        final directory = await _downloadsDirectory();

        await directory.create(recursive: true);
        final target = File(p.join(directory.path, _fileName(update)));
        final partial = File('${target.path}$_partialSuffix');
        final response = await client.send(http.Request('GET', Uri.parse(update.apkUrl)));

        if (response.statusCode != HttpStatus.ok) {
          throw HttpException('APK download responded with ${response.statusCode}');
        }

        final total = response.contentLength ?? update.apkSize;
        final step = total > 0 ? total ~/ _progressSteps : 0;
        final sink = partial.openWrite();
        var received = 0;
        var reported = 0;

        try {
          await for (final chunk in response.stream) {
            sink.add(chunk);
            received += chunk.length;

            if (received - reported >= step) {
              reported = received;
              controller.add(DownloadProgress(received: received, total: total));
            }
          }
        } finally {
          await sink.close();
        }

        if (total > 0 && received != total) {
          throw HttpException('APK download incomplete: $received of $total bytes');
        }

        await partial.rename(target.path);
        controller.add(DownloadProgress(received: received, total: total, filePath: target.path));
      } on Exception catch (error, stack) {
        controller.addError(error, stack);
      } finally {
        client.close();
        await controller.close();
      }
    }

    controller = StreamController<DownloadProgress>(onListen: download, onCancel: client.close);

    return controller.stream;
  }

  @override
  Future<String?> findDownloadedApk(AppUpdate update) async {
    final directory = await _downloadsDirectory();
    final file = File(p.join(directory.path, _fileName(update)));

    if (!await file.exists()) {
      return null;
    }

    if (update.apkSize > 0 && await file.length() != update.apkSize) {
      await file.delete();

      return null;
    }

    return file.path;
  }

  @override
  Future<void> clearDownloads({AppUpdate? keep}) async {
    final directory = await _downloadsDirectory();

    if (!await directory.exists()) {
      return;
    }

    final kept = keep == null ? null : p.join(directory.path, _fileName(keep));

    await for (final entity in directory.list()) {
      if (entity.path != kept) {
        await entity.delete(recursive: true);
      }
    }
  }
}
