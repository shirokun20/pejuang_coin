const String stub = """
// ignore_for_file: unused_field
import 'package:modular_asix/components/base/base_repository.dart';
import '../{MODULE}.dart';

class {NMMODULE}Repository extends BaseRepository {
  final {NMMODULE}DataSource _dataSource;
  {NMMODULE}Repository(this._dataSource);
}
""";

const String stubCuston = """
// ignore_for_file: unused_field
import 'package:modular_asix/components/base/base_repository.dart';

class {REPONM}Repository extends BaseRepository {
  
}
""";
