import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<List<XFile>> pickGalleryMedia(int limit) async {
  final picker = ImagePicker();

  if (limit == 1) {
    final media = await picker.pickMedia();

    return media == null ? const [] : [media];
  }

  return picker.pickMultipleMedia(limit: limit);
}

Future<List<XFile>> pickAnyFiles(int limit) async {
  final files = await FilePicker.pickFiles();

  return files.take(limit).map((file) => file.xFile).toList();
}
