const String stub = """
// ignore_for_file: unused_field
import 'package:get/get.dart';
import '../{MODULE}.dart';

class {CONTROLLER}Controller extends GetxController {
  final {CONTROLLER}Repository _repository;
  {CONTROLLER}Controller(this._repository);
}
""";

const String stubCuston = """
// ignore_for_file: unused_field
import 'package:get/get.dart';

class {CONTROLLER}Controller extends GetxController {
}
""";
