import 'package:sqflite/sqflite.dart';
import '../db/data_base.dart';
import '../dominio/detallePedido.dart';

class DAODetallePedidos {
  static final DAODetallePedidos _instancia = DAODetallePedidos._inicializar();

  DAODetallePedidos._inicializar();

  factory DAODetallePedidos() {
    return _instancia;
  }

  Future<List<DetallePedido>> obtenerDetallesPorPedido(int pedidoId) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query(
      'detalle_pedidos',
      where: 'pedidoId = ?',
      whereArgs: [pedidoId],
    );

    return resultados.map((mapa) => DetallePedido.fromMap(mapa)).toList();
  }

  Future<int> agregarDetallePedido(DetallePedido detalle) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> detalleMap = detalle.toMap();

    return await db.insert('detalle_pedidos', detalleMap);
  }

  Future<int> modificarDetallePedido(DetallePedido detalleModificado) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> detalleMap = detalleModificado.toMap();

    return await db.update(
      'detalle_pedidos',
      detalleMap,
      where: 'id = ?',
      whereArgs: [detalleModificado.id],
    );
  }

  Future<int> eliminarDetallePedido(int id) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    return await db.delete(
      'detalle_pedidos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
