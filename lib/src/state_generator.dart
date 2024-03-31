// ignore_for_file: avoid_print
import 'package:dcli/dcli.dart';
import '../module/state/module_state.dart' as modulestate;
import 'utilities/utilities.dart';

String moduleName = "";
String modulePath = "";
String stateName = "";
String statePath = "";

Future<void> generate(List<String> args) async {
  /// Validate arguments
  if (!_validateArgs(args)) return;

  /// Assign variable values
  stateName = args.first;

  statePath = "lib/features/${Utils.snake(moduleName)}/presentation";

  /// Generate state
  await generateState();
}

/// Generate modulestate
Future<void> generateState() async {
  /// Check and create directory
  Utils.makeDir(statePath);

  String stateFile =
      modulestate.stub.replaceAll('{MODULE}', Utils.camel(stateName));

  /// Write File
  Utils.writeFile("$statePath/${Utils.snake(stateName)}_state.dart", stateFile);

  /// Show Success message
  print(green(
      '"$statePath/${Utils.snake(stateName)}_state.dart" generated successfully.'));
}

bool _validateArgs(List<String> args) {
  /// Check if there are any args
  if (args.isEmpty) {
    print(red(
        'Please provide state name and module name\nExample "flutter pub run asix:state StateName --on=module_name"'));
    return false;
  }

  /// Get the module name
  moduleName = args.where((element) => element.contains('--on=')).isNotEmpty
      ? args.where((element) => element.contains('--on=')).first
      : "";

  /// Check if the module name is provided or not.
  if (moduleName == "") {
    print(red(
        'Please provide module name to generate the state\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module name
  moduleName = moduleName.replaceAll('--on=', '');

  /// Check if the module name is provided or not.
  if (moduleName.trim().isEmpty) {
    print(red(
        'Module name cannot be empty. Please provide module name to generate the state\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module path
  modulePath = "lib/features/${Utils.snake(moduleName)}";

  /// Check if the module exists or not
  if (!Utils.isExists(modulePath)) {
    print(red('The module with name "$moduleName" does not exist.'));
    return false;
  }
  return true;
}
