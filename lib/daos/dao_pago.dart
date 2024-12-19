import 'package:sqflite/sqflite.dart';
import '../db/data_base.dart';
import '../dominio/pago.dart';

class DAOPagos {
  static final DAOPagos _instancia = DAOPagos._inicializar();

  DAOPagos._inicializar();

  factory DAOPagos() {
    return _instancia;
  }

  Future<List<Pago>> obtenerPagos() async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query('pagos');

    return resultados.map((mapa) => Pago.fromMap(mapa)).toList();
  }

  Future<Pago?> obtenerPagoPorId(int id) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query(
      'pagos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultados.isNotEmpty) {
      return Pago.fromMap(resultados.first);
    }
    return null;
  }

  Future<List<Pago>> obtenerPagosPorPedido(int pedidoId) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query(
      'pagos',
      where: 'pedidoId = ?',
      whereArgs: [pedidoId],
    );

    return resultados.map((mapa) => Pago.fromMap(mapa)).toList();
  }

  Future<int> agregarPago(Pago pago) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> pagoMap = pago.toMap();

    return await db.insert('pagos', pagoMap);
  }

  Future<int> modificarPago(Pago pagoModificado) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> pagoMap = pagoModificado.toMap();

    return await db.update(
      'pagos',
      pagoMap,
      where: 'id = ?',
      whereArgs: [pagoModificado.id],
    );
  }

  Future<int> eliminarPago(int id) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    return await db.delete(
      'pagos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
