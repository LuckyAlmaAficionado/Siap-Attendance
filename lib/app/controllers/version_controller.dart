import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionController extends GetxController {
  androidAppsVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }
}
