import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Loader extends GetxController {
  loadingDismiss() {
    // EasyLoading.showSuccess('Data Fetched');
    EasyLoading.dismiss();
  }

  loadingShow() {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }
}
