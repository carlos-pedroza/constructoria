import '../entities/perfil.dart';

abstract class CreatePerfil {
  Future<Perfil> call(String nombre);
}
