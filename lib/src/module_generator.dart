// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dcli/dcli.dart';

import '../module/controller/module_controller.dart' as mcontroller;
import '../module/screen/module_screen.dart' as mscreen;
import '../module/module.dart' as mdata;
import '../module/router/module_router.dart' as mroute;
import '../module/router/module_main_router.dart' as mmainroute;
import '../module/state/module_state.dart' as mstate;
import '../module/binding/module_binding.dart' as mbinding;
import '../module/repository/module_datasource.dart' as mds;
import '../module/repository/module_repository.dart' as mrepo;

import 'utilities/utilities.dart';

String moduleName = "";
String modulePath = "";
String controllerPath = "";
String viewPath = "";
String statePath = "";
String routePath = "";
String routerMainPath = "";
String routerMainImport = "";
String bindingPath = "";
String drPath = "";

Future<void> generate(List<String> args) async {
  /// Assign variable values
  moduleName = args.first;
  modulePath = "lib/features/${Utils.snake(moduleName)}";
  controllerPath = "lib/features/${Utils.snake(moduleName)}/presentation";
  viewPath = "lib/features/${Utils.snake(moduleName)}/presentation";
  statePath = "lib/features/${Utils.snake(moduleName)}/presentation";
  routePath = "lib/features/${Utils.snake(moduleName)}/router";
  bindingPath = "lib/features/${Utils.snake(moduleName)}/binding";
  drPath = "lib/features/${Utils.snake(moduleName)}/repository";
  routerMainPath = "lib/components/config/app_routes.dart";
  routerMainImport = "import 'package:modular_asix/screen/";

  /// Generate Controller
  await generateController();

  /// Generate Route
  await generateModuleClass();

  /// Generate Screen
  await generateScreen();

  /// Generate Route
  await generateRoute();

  /// Generate State
  await generateState();

  /// Generate Binding
  await generateBinding();

  /// Generate Repository
  await generateRepository();

  /// Generate Datasource
  await generateDatasource();

  /// Update Route
  await updateRouteFile();
}

/// Generate ModuleController
Future<void> generateController() async {
  /// Check and create directory
  Utils.makeDir(controllerPath);

  String controllerFile =
      mcontroller.stub.replaceAll('{CONTROLLER}', Utils.camel(moduleName));
  controllerFile =
      controllerFile.replaceAll('{MODULE}', Utils.snake(moduleName));

  /// Write File
  Utils.writeFile("$controllerPath/${Utils.snake(moduleName)}_controller.dart",
      controllerFile);

  /// Show Success message
  print(green(
      '"$controllerPath/${Utils.snake(moduleName)}_controller.dart" generated successfully!'));
}

/// Generate ModuleClass
Future<void> generateModuleClass() async {
  /// Check and create directory
  Utils.makeDir(modulePath);

  String moduleFile =
      mdata.stub.replaceAll('{MODULE}', Utils.snake(moduleName));

  /// Write File
  Utils.writeFile("$modulePath/${Utils.snake(moduleName)}.dart", moduleFile);

  /// Show Success message
  print(green(
      '"$modulePath/${Utils.snake(moduleName)}.dart" generated successfully!'));
}

/// Generate ModuleScreen
Future<void> generateScreen() async {
  /// Check and create directory
  Utils.makeDir(viewPath);

  /// Process View File
  String viewFile = mscreen.stub.replaceAll('{PAGE}', Utils.camel(moduleName));
  viewFile = viewFile.replaceAll('{MODULE}', Utils.snake(moduleName));
  viewFile = viewFile.replaceAll('{NMMODULE}', Utils.camel(moduleName));

  /// Write File
  Utils.writeFile("$viewPath/${Utils.snake(moduleName)}_screen.dart", viewFile);

  /// Show Success message
  print(green(
      '"$viewPath/${Utils.snake(moduleName)}_screen.dart" generated successfully!'));
}

/// Generate ModuleRoute
Future<void> generateRoute() async {
  /// Check and create directory
  Utils.makeDir(routePath);

  /// Process Router File
  String routeFile =
      mroute.stub.replaceAll('{MODULE}', Utils.camel(moduleName));
  routeFile = routeFile.replaceAll('{MODULE_URL}', Utils.kebab(moduleName));
  routeFile = routeFile.replaceAll('{MODULE_SCREEN}', Utils.snake(moduleName));

  /// Write File
  Utils.writeFile(
      "$routePath/${Utils.snake(moduleName)}_router.dart", routeFile);

  /// Show Success message
  print(green(
      '"$routePath/${Utils.snake(moduleName)}_router.dart" generated successfully!'));
}

/// Generate ModuleState
Future<void> generateState() async {
  /// Check and create directory
  Utils.makeDir(viewPath);

  /// Process View File
  String stateFile =
      mstate.stub.replaceAll('{MODULE}', Utils.camel(moduleName));

  /// Write File
  Utils.writeFile(
      "$statePath/${Utils.snake(moduleName)}_state.dart", stateFile);

  /// Show Success message
  print(green(
      '"$statePath/${Utils.snake(moduleName)}_state.dart" generated successfully!'));
}

/// Generate ModuleBinding
Future<void> generateBinding() async {
  /// Check and create directory
  Utils.makeDir(bindingPath);
  // Process View File
  String bindingFile =
      mbinding.stub.replaceAll('{MODULE}', Utils.snake(moduleName));
  bindingFile = bindingFile.replaceAll('{NMMODULE}', Utils.camel(moduleName));

  /// Write File
  Utils.writeFile(
      "$bindingPath/${Utils.snake(moduleName)}_binding.dart", bindingFile);

  /// Show Success message
  print(green(
      '"$bindingPath/${Utils.snake(moduleName)}_binding.dart" generated successfully!'));
}

Future<void> generateDatasource() async {
  /// Check and create directory
  Utils.makeDir(drPath);

  // Process View File
  String dsFile = mds.stub.replaceAll('{MODULE}', Utils.camel(moduleName));

  /// Write File
  Utils.writeFile("$drPath/${Utils.snake(moduleName)}_datasource.dart", dsFile);

  /// Show Success message
  print(green(
      '"$drPath/${Utils.snake(moduleName)}_datasource.dart" generated successfully!'));
}

Future<void> generateRepository() async {
  /// Check and create directory
  Utils.makeDir(drPath);

  // Process View File
  String dsFile = mrepo.stub.replaceAll('{MODULE}', Utils.snake(moduleName));
  dsFile = dsFile.replaceAll('{NMMODULE}', Utils.camel(moduleName));

  /// Write File
  Utils.writeFile("$drPath/${Utils.snake(moduleName)}_repository.dart", dsFile);

  /// Show Success message
  print(green(
      '"$drPath/${Utils.snake(moduleName)}_repository.dart" generated successfully!'));
}

Future<void> updateRouteFile() async {
  File file = File(routerMainPath);
  String existingContent = file.readAsStringSync();
  String importContent = mmainroute.stubImportPackage
      .replaceAll("{MODULE}", Utils.snake(moduleName));
  int indexStartImport = existingContent.indexOf(routerMainImport);
  int indexEndImport = existingContent.indexOf(".dart';", indexStartImport);
  if (!existingContent.contains(importContent)) {
    String updatedContent =
        "${existingContent.substring(0, indexEndImport + 7)}$importContent${existingContent.substring(indexEndImport + 7)}";

    String additionalContent = mmainroute.stubImportRouter
        .replaceAll("{MODULE}", Utils.camel(moduleName));

    int indexRoutes = updatedContent.lastIndexOf('List<GetPage> routes');

    int indexEndRoutes = updatedContent.indexOf('];', indexRoutes);

    String newContent = updatedContent.substring(0, indexEndRoutes) +
        additionalContent +
        updatedContent.substring(indexEndRoutes);

    file.writeAsStringSync(newContent);
    print(green('"$routerMainPath" Update app_router.dart successfully!'));
  } else {
    print(red(
        '"$routerMainPath" Update Router already exists in main app_router.dart'));
  }
}
