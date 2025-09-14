// Bloc State
import 'package:constructoria/domain/entities/perfil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerfilesState {
  final List<Perfil> perfiles;
  PerfilesState(this.perfiles);
}

// Bloc Events
abstract class PerfilesEvent {}
class SetPerfiles extends PerfilesEvent {
  final List<Perfil> perfiles;
  SetPerfiles(this.perfiles);
}
class UpdatePerfilAcceso extends PerfilesEvent {
  final int idperfil;
  final bool acceso;
  final int? idempleadoPerfil;
  UpdatePerfilAcceso(this.idperfil, this.acceso, this.idempleadoPerfil);
}

// Bloc Implementation
class PerfilesBloc extends Bloc<PerfilesEvent, PerfilesState> {
  PerfilesBloc() : super(PerfilesState([])) {
    on<SetPerfiles>((event, emit) {
      emit(PerfilesState(List<Perfil>.from(event.perfiles)));
    });
    on<UpdatePerfilAcceso>((event, emit) {
      final updated = state.perfiles.map((p) =>
        p.idperfil == event.idperfil ? p.copyWith(acceso: event.acceso, idempleadoPerfil: event.idempleadoPerfil): p
      ).toList();
      emit(PerfilesState(updated));
    });
  }
}