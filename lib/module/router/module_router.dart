const String stub = """
import 'package:get/get.dart';
import '../{MODULE_SCREEN}.dart';

class {MODULE}Router {
  static String get {MODULE_URL} => '/{MODULE_URL}';
  static List<GetPage> pages = [
    GetPage(
      name: {MODULE_URL},
      page: () => const {MODULE}Screen(),
      binding: {MODULE}Binding(),
    ),
  ];
}
""";
