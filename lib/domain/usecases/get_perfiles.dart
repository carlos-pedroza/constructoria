import '../entities/perfil.dart';

abstract class GetPerfiles {
  Future<List<Perfil>> call();
}
