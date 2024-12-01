import 'package:get/get.dart';

class PrintSettingsController extends GetxController {
  static RxString selectedTemplate = 'Template 1'.obs;
  static RxString printSize = 'A4'.obs;
  static RxString pageOrientation = 'portrait'.obs;

  static void setSelectedTemplate(String name) {
    selectedTemplate.value = name;
  }

  static void setPrintSize(String size) {
    printSize.value = size;
  }

  static void setPageOrientation(String orientation) {
    pageOrientation.value = orientation;
  }
}
