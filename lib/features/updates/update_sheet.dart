import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_version_provider.dart';
import '../../core/logger.dart';
import '../../core/theme/theme_context.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_sheet.dart';
import '../../core/widgets/field_row.dart';
import '../../core/widgets/group_card.dart';
import '../../core/widgets/pill_button.dart';
import '../../core/widgets/section_label.dart';
import '../../core/widgets/sheet_header.dart';
import '../../data/data_providers.dart';
import '../../domain/models/app_update.dart';
import '../../domain/models/download_progress.dart';
import '../../l10n/app_localizations.dart';
import 'apk_installer.dart';
import 'release_notes.dart';
import 'updates_controller.dart';
import 'widgets/download_progress_view.dart';

Future<void> showUpdateSheet(BuildContext context, AppUpdate update) {
  return showAppSheet<void>(context, (_) {
    return UpdateSheet(update: update);
  });
}

class UpdateSheet extends ConsumerStatefulWidget {
  const UpdateSheet({required this.update, super.key});

  final AppUpdate update;

  @override
  ConsumerState<UpdateSheet> createState() {
    return _UpdateSheetState();
  }
}

class _UpdateSheetState extends ConsumerState<UpdateSheet> {
  static const _notesMaxHeight = 220.0;

  StreamSubscription<DownloadProgress>? _download;
  DownloadProgress? _progress;
  String? _downloadedPath;
  String? _error;

  bool get _downloading => _download != null;

  @override
  void initState() {
    super.initState();
    unawaited(_findDownloaded());
  }

  Future<void> _findDownloaded() async {
    final path = await ref.read(updatesRepositoryProvider).findDownloadedApk(widget.update);

    if (mounted && path != null) {
      setState(() {
        _downloadedPath = path;
      });
    }
  }

  @override
  void dispose() {
    unawaited(_download?.cancel());
    super.dispose();
  }

  void _start() {
    final downloaded = _downloadedPath;

    if (downloaded != null) {
      talker.info('Update ${widget.update.version} already downloaded, installing');
      unawaited(_install(downloaded));

      return;
    }

    setState(() {
      _error = null;
      _progress = null;
      _download = ref
          .read(updatesRepositoryProvider)
          .downloadApk(widget.update)
          .listen(_onProgress, onError: _onError, cancelOnError: true);
    });
    talker.info('Update ${widget.update.version} download started');
  }

  void _onProgress(DownloadProgress progress) {
    final path = progress.filePath;

    if (path == null) {
      setState(() {
        _progress = progress;
      });

      return;
    }

    _downloadedPath = path;
    unawaited(_install(path));
  }

  void _onError(Object error, StackTrace stack) {
    talker.handle(error, stack, 'Update download failed');

    if (!mounted) {
      return;
    }

    setState(() {
      _download = null;
      _error = AppLocalizations.of(context).downloadFailed;
    });
  }

  Future<void> _install(String path) async {
    final failedText = AppLocalizations.of(context).installFailed;
    final opened = await installApk(path);

    if (!mounted) {
      return;
    }

    if (opened) {
      Navigator.of(context).pop();

      return;
    }

    talker.warning('Installer did not open for $path');
    setState(() {
      _download = null;
      _error = failedText;
    });
  }

  Future<void> _cancel() async {
    await _download?.cancel();
    setState(() {
      _download = null;
      _progress = null;
    });
    talker.info('Update download cancelled');
  }

  Future<void> _postpone() async {
    final navigator = Navigator.of(context);

    await ref.read(updatesControllerProvider.notifier).postpone(widget.update);
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final currentVersion = ref.watch(appVersionProvider).value;
    final notes = releaseNotesToPlainText(widget.update.notes);
    final error = _error;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetHeader(l.updateAvailable(widget.update.version)),
            GroupCard(
              children: [
                if (currentVersion != null) FieldRow(label: l.updateInstalledVersion, value: currentVersion),
                if (widget.update.apkSize > 0)
                  FieldRow(label: l.updateDownloadSize, value: formatMegabytes(context, widget.update.apkSize)),
              ],
            ),
            if (notes.isNotEmpty) ...[
              SectionLabel(l.whatsNew),
              Flexible(
                child: GroupCard(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: _notesMaxHeight),
                      child: SingleChildScrollView(
                        child: Text(notes, style: TextStyle(fontSize: 14, height: 1.4, color: p.text)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (_downloading) ...[
              DownloadProgressView(progress: _progress),
              const SizedBox(height: 12),
              PillButton(label: l.cancel, filled: false, onTap: _cancel),
            ] else ...[
              if (error != null) ...[
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: p.danger),
                ),
                const SizedBox(height: 12),
              ],
              PillButton(
                label: error != null
                    ? l.retry
                    : _downloadedPath != null
                    ? l.installUpdate
                    : l.updateNow,
                icon: Icons.system_update_alt_rounded,
                onTap: _start,
              ),
              const SizedBox(height: 8),
              PillButton(label: l.updateLater, filled: false, onTap: _postpone),
            ],
          ],
        ),
      ),
    );
  }
}
