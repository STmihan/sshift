import 'package:open_filex/open_filex.dart';

const _apkMimeType = 'application/vnd.android.package-archive';

Future<bool> installApk(String path) async {
  final result = await OpenFilex.open(path, type: _apkMimeType);

  return result.type == ResultType.done;
}
