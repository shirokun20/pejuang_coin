const String stub = """
abstract class {MODULE}State {}
class {MODULE}Loading extends {MODULE}State {}
class {MODULE}Empty extends {MODULE}State {}
class {MODULE}Idle extends {MODULE}State {}
class {MODULE}Error extends {MODULE}State {}
class {MODULE}Success extends {MODULE}State {}
""";
