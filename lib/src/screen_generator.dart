// ignore_for_file: avoid_print

import 'package:dcli/dcli.dart';
import '../module/screen/module_screen.dart' as modulescreen;
import 'utilities/utilities.dart';

String moduleName = "";
String modulePath = "";
String viewName = "";
String viewPath = "";

Future<void> generate(List<String> args) async {
  /// Validate arguments
  if (!_validateArgs(args)) return;

  /// Assign variable values
  viewName = args.first;

  viewPath = "lib/features/${Utils.snake(moduleName)}/presentation";

  /// Generate Controller
  await generateController();
}

/// Generate ModuleController
Future<void> generateController() async {
  /// Check and create directory
  Utils.makeDir(viewPath);

  String viewFile =
      modulescreen.stubCustom.replaceAll('{PAGE}', Utils.camel(viewName));

  /// Write File
  Utils.writeFile("$viewPath/${Utils.snake(viewName)}_screen.dart", viewFile);

  /// Show Success message
  print(green(
      '"$viewPath/${Utils.snake(viewName)}_screen.dart" generated successfully.'));
}

bool _validateArgs(List<String> args) {
  /// Check if there are any args
  if (args.isEmpty) {
    print(red(
        'Please provide view name and module name\nExample "flutter pub run asix:screen ScreenName --on=module_name"'));
    return false;
  }

  /// Get the module name
  moduleName = args.where((element) => element.contains('--on=')).isNotEmpty
      ? args.where((element) => element.contains('--on=')).first
      : "";

  /// Check if the module name is provided or not.
  if (moduleName == "") {
    print(red(
        'Please provide module name to generate the page\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module name
  moduleName = moduleName.replaceAll('--on=', '');

  /// Check if the module name is provided or not.
  if (moduleName.trim().isEmpty) {
    print(red(
        'Module name cannot be empty. Please provide module name to generate the screen\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module path
  modulePath = "lib/features/${Utils.snake(moduleName)}";

  /// Check if the module exists or not
  if (!exists(modulePath)) {
    print(red('The module with name "$moduleName" does not exist.'));
    return false;
  }
  return true;
}
