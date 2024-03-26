// ignore_for_file: avoid_print
import 'package:dcli/dcli.dart';
import '../module/controller/module_controller.dart' as modulecontroller;
import 'utilities/utilities.dart';

String moduleName = "";
String modulePath = "";
String controllerName = "";
String controllerPath = "";

Future<void> generate(List<String> args) async {
  /// Validate arguments
  if (!_validateArgs(args)) return;

  /// Assign variable values
  controllerName = args.first;

  controllerPath = "lib/screen/${Utils.snake(moduleName)}/presentation";

  /// Generate Controller
  await generateController();
}

/// Generate ModuleController
Future<void> generateController() async {
  /// Check and create directory
  Utils.makeDir(controllerPath);

  String controllerFile = modulecontroller.stubCuston
      .replaceAll('{CONTROLLER}', Utils.camel(controllerName));

  /// Write File
  Utils.writeFile(
      "$controllerPath/${Utils.snake(controllerName)}_controller.dart",
      controllerFile);

  /// Show Success message
  print(green(
      '"$controllerPath/${Utils.snake(controllerName)}_controller.dart" generated successfully.'));
}

bool _validateArgs(List<String> args) {
  /// Check if there are any args
  if (args.isEmpty) {
    print(red(
        'Please provide controller name and module name\nExample "flutter pub run asix:controller ControllerName --on=module_name"'));
    return false;
  }

  /// Get the module name
  moduleName = args.where((element) => element.contains('--on=')).isNotEmpty
      ? args.where((element) => element.contains('--on=')).first
      : "";

  /// Check if the module name is provided or not.
  if (moduleName == "") {
    print(red(
        'Please provide module name to generate the controller\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module name
  moduleName = moduleName.replaceAll('--on=', '');

  /// Check if the module name is provided or not.
  if (moduleName.trim().isEmpty) {
    print(red(
        'Module name cannot be empty. Please provide module name to generate the controller\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module path
  modulePath = "lib/screen/${Utils.snake(moduleName)}";

  /// Check if the module exists or not
  if (!Utils.isExists(modulePath)) {
    print(red('The module with name "$moduleName" does not exist.'));
    return false;
  }
  return true;
}
