import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraDataController extends GetxController {
  late CameraDescription _camera;
  late ImagePicker _imagePicker;
  XFile? _imageFile;

  @override
  void onInit() {
    super.onInit();
    _imagePicker = ImagePicker();
  }

  CameraDescription get camera => _camera;

  void setCamera(CameraDescription camera) {
    _camera = camera;
    update(); // Update state
  }

  Future<XFile> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      _imageFile = pickedFile;
      return _imageFile!;
    } catch (e) {
      print('Error: $e');
      return _imageFile!;
    }
  }
}
