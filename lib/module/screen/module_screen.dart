const String stub = """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../{MODULE}.dart';

class {PAGE}Screen extends GetView<{NMMODULE}Controller> {
  const {PAGE}Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Build awesome page here."),
      ),
    );
  }
}
""";

const String stubCustom = """
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class {PAGE}Screen extends GetView {
  const {PAGE}Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Build awesome page here."),
      ),
    );
  }
}
""";
