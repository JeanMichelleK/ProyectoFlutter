import 'package:sqflite/sqflite.dart';
import '../db/data_base.dart';
import '../dominio/pedido.dart';

class DAOPedidos {
  static final DAOPedidos _instancia = DAOPedidos._inicializar();

  DAOPedidos._inicializar();

  factory DAOPedidos() {
    return _instancia;
  }

  Future<List<Pedido>> obtenerPedidos() async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query('pedidos');

    return resultados.map((mapa) => Pedido.fromMap(mapa)).toList();
  }

  Future<Pedido?> obtenerPedidoPorId(int id) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query(
      'pedidos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultados.isNotEmpty) {
      return Pedido.fromMap(resultados.first);
    }
    return null;
  }

  Future<List<Pedido>> obtenerPedidosPorCliente(int cedula) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query(
      'pedidos',
      where: 'clienteCedula = ?',
      whereArgs: [cedula],
    );

    return resultados.map((mapa) => Pedido.fromMap(mapa)).toList();
  }

  Future<int> agregarPedido(Pedido pedido) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> pedidoMap = pedido.toMap();

    return await db.insert('pedidos', pedidoMap);
  }

  Future<int> modificarPedido(Pedido pedidoModificado) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> pedidoMap = pedidoModificado.toMap();

    return await db.update(
      'pedidos',
      pedidoMap,
      where: 'id = ?',
      whereArgs: [pedidoModificado.id],
    );
  }

  Future<int> eliminarPedido(int id) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    return await db.delete(
      'pedidos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
