// ignore_for_file: avoid_print
import 'package:dcli/dcli.dart';
import '../module/repository/module_datasource.dart' as mdlds;
import 'utilities/utilities.dart';

String moduleName = "";
String modulePath = "";
String datasourceName = "";
String datasourcePath = "";

Future<void> generate(List<String> args) async {
  /// Validate arguments
  if (!_validateArgs(args)) return;

  /// Assign variable values
  datasourceName = args.first;

  datasourcePath = "lib/screen/${Utils.snake(moduleName)}/repository";

  /// Generate datasource
  await generateDs();
}

/// Generate Moduledatasource
Future<void> generateDs() async {
  /// Check and create directory
  Utils.makeDir(datasourcePath);

  String datasourceFile =
      mdlds.stub.replaceAll('{MODULE}', Utils.camel(datasourceName));

  /// Write File
  Utils.writeFile(
      "$datasourcePath/${Utils.snake(datasourceName)}_datasource.dart",
      datasourceFile);

  /// Show Success message
  print(green(
      '"$datasourcePath/${Utils.snake(datasourceName)}_datasource.dart" generated successfully.'));
}

bool _validateArgs(List<String> args) {
  /// Check if there are any args
  if (args.isEmpty) {
    print(red(
        'Please provide datasource name and module name\nExample "flutter pub run asix:datasource DatasourceName --on=module_name"'));
    return false;
  }

  /// Get the module name
  moduleName = args.where((element) => element.contains('--on=')).isNotEmpty
      ? args.where((element) => element.contains('--on=')).first
      : "";

  /// Check if the module name is provided or not.
  if (moduleName == "") {
    print(red(
        'Please provide module name to generate the datasource\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module name
  moduleName = moduleName.replaceAll('--on=', '');

  /// Check if the module name is provided or not.
  if (moduleName.trim().isEmpty) {
    print(red(
        'Module name cannot be empty. Please provide module name to generate the datasource\nExample [--on=<module_name>]'));
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
