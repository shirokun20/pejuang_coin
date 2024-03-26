const String stub = """
import 'package:get/get.dart';
import '../{MODULE}.dart';

class {NMMODULE}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => {NMMODULE}Controller(Get.find()), fenix: true);
    Get.lazyPut(() => {NMMODULE}DataSource(Get.find()));
    Get.lazyPut(() => {NMMODULE}Repository(Get.find()));
  }
}

""";
