// ignore_for_file: avoid_print
import 'package:dcli/dcli.dart';
import '../module/repository/module_repository.dart' as mdlrepo;
import 'utilities/utilities.dart';

String moduleName = "";
String modulePath = "";
String repositoryName = "";
String repositoryPath = "";

Future<void> generate(List<String> args) async {
  /// Validate arguments
  if (!_validateArgs(args)) return;

  /// Assign variable values
  repositoryName = args.first;

  repositoryPath = "lib/screen/${Utils.snake(moduleName)}/repository";

  /// Generate Repository
  await generateRepo();
}

/// Generate ModuleRepository
Future<void> generateRepo() async {
  /// Check and create directory
  Utils.makeDir(repositoryPath);

  String repoFile =
      mdlrepo.stubCuston.replaceAll('{REPONM}', Utils.camel(repositoryName));

  /// Write File
  Utils.writeFile(
      "$repositoryPath/${Utils.snake(repositoryName)}_repository.dart",
      repoFile);

  /// Show Success message
  print(green(
      '"$repositoryPath/${Utils.snake(repositoryName)}_repository.dart" generated successfully.'));
}

bool _validateArgs(List<String> args) {
  /// Check if there are any args
  if (args.isEmpty) {
    print(red(
        'Please provide controller name and module name\nExample "flutter pub run asix:repository repositoryName --on=module_name"'));
    return false;
  }

  /// Get the module name
  moduleName = args.where((element) => element.contains('--on=')).isNotEmpty
      ? args.where((element) => element.contains('--on=')).first
      : "";

  /// Check if the module name is provided or not.
  if (moduleName == "") {
    print(red(
        'Please provide module name to generate the repository\nExample [--on=<module_name>]'));
    return false;
  }

  /// Assign module name
  moduleName = moduleName.replaceAll('--on=', '');

  /// Check if the module name is provided or not.
  if (moduleName.trim().isEmpty) {
    print(red(
        'Module name cannot be empty. Please provide module name to generate the repository\nExample [--on=<module_name>]'));
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
