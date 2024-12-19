import 'package:sqflite/sqflite.dart';
import '../db/data_base.dart';
import '../dominio/clientes.dart';

class DAOClientes {
  static final DAOClientes _instancia = DAOClientes._inicializar();

  DAOClientes._inicializar();

  factory DAOClientes() {
    return _instancia;
  }

  Future<List<Cliente>> obtenerClientes() async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query('clientes');

    return resultados.map((mapa) => Cliente.fromMap(mapa)).toList();
  }

  Future<Cliente?> obtenerClientePorCedula(int cedula) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final List<Map<String, Object?>> resultados = await db.query(
      'clientes',
      where: 'cedula = ?',
      whereArgs: [cedula],
    );

    if (resultados.isNotEmpty) {
      return Cliente.fromMap(resultados.first);
    }
    return null;
  }

  Future<int> agregarCliente(Cliente cliente) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> clienteMap = cliente.toMap();

    return await db.insert('clientes', clienteMap);
  }

  Future<int> modificarCliente(Cliente clienteModificado) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    final Map<String, Object?> clienteMap = clienteModificado.toMap();

    return await db.update(
      'clientes',
      clienteMap,
      where: 'cedula = ?',
      whereArgs: [clienteModificado.cedula],
    );
  }

  Future<int> eliminarCliente(int cedula) async {
    final Database db = await BaseDatos().obtenerBaseDatos();
    return await db.delete(
      'clientes',
      where: 'cedula = ?',
      whereArgs: [cedula],
    );
  }
}
