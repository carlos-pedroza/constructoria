class TareaGastoQueries {
  static const String createTareaGasto = '''
    INSERT INTO tarea_gasto (idtarea, id_tipo_gasto, costo, creado)
    VALUES (?, ?, ?, ?)
  ''';

  static const String updateTareaGasto = '''
    UPDATE tarea_gasto SET idtarea = ?, id_tipo_gasto = ?, costo = ?, creado = ?
    WHERE idtarea_gasto = ?
  ''';

  static const String deleteTareaGasto = '''
    DELETE FROM tarea_gasto WHERE idtarea_gasto = ?
  ''';

  static const String getTareaGastoById = '''
    SELECT * FROM tarea_gasto WHERE idtarea_gasto = ?
  ''';

  static const String getTareaGastosByTarea = '''
    SELECT * FROM tarea_gasto WHERE idtarea = ?
  ''';
}
