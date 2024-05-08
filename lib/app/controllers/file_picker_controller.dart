import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class FilePickerController extends GetxController {
  RxString? filePath;

  Future<void> openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        filePath!.value = result.files.single.path!;
      } else {
        // ... user tidak memilih file
      }
    } catch (e) {
      // ... penanganan
      throw ("terjadi error [_openFilePicker]: $e");
    }
  }

  Future<String> openFileExplorerPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg'],
    );

    if (result != null) {
      // filePath!.value = result.files.single.path!;
      return result.files.single.path!;
    }
    return '';
  }
}
