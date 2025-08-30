import '../entities/perfil.dart';

abstract class UpdatePerfil {
  Future<Perfil> call(Perfil perfil);
}
