class TareaMaterialQueries {
  static const String createTareaMaterial = '''
    INSERT INTO tarea_material (idtarea, id_material, cantidad, costo, creado)
    VALUES (?, ?, ?, ?, ?)
  ''';

  static const String updateTareaMaterial = '''
    UPDATE tarea_material SET idtarea = ?, id_material = ?, cantidad = ?, costo = ?, creado = ?
    WHERE idtarea_material = ?
  ''';

  static const String deleteTareaMaterial = '''
    DELETE FROM tarea_material WHERE idtarea_material = ?
  ''';

  static const String getTareaMaterialById = '''
    SELECT * FROM tarea_material WHERE idtarea_material = ?
  ''';

  static const String getTareaMaterialesByTarea = '''
    SELECT * FROM tarea_material WHERE idtarea = ?
  ''';
}
