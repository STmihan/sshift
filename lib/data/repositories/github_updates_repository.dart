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
  static const _headers = {
    'Accept': 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28',
  };
  static const _progressSteps = 200;

  Future<Directory> get _downloadsDirectory async {
    final temp = await getTemporaryDirectory();

    return Directory(p.join(temp.path, 'updates'));
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
        final directory = await _downloadsDirectory;

        await directory.create(recursive: true);
        final file = File(p.join(directory.path, 'sshift-${update.version}.apk'));
        final response = await client.send(http.Request('GET', Uri.parse(update.apkUrl)));

        if (response.statusCode != HttpStatus.ok) {
          throw HttpException('APK download responded with ${response.statusCode}');
        }

        final total = response.contentLength ?? update.apkSize;
        final step = total > 0 ? total ~/ _progressSteps : 0;
        final sink = file.openWrite();
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

        controller.add(DownloadProgress(received: received, total: total, filePath: file.path));
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
  Future<void> clearDownloads() async {
    final directory = await _downloadsDirectory;

    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}
