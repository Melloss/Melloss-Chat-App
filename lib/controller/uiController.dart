import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIController extends GetxController {
  RxBool isLoggedBefore = false.obs;
  void initSettings() async {
    final preference = await SharedPreferences.getInstance();
    if (preference.containsKey('isLoggedBefore') == false) {
      preference.setBool('isLoggedBefore', false);
      isLoggedBefore.value = false;
    } else {
      isLoggedBefore.value = preference.getBool('isLoggedBefore')!;
    }
  }
}
