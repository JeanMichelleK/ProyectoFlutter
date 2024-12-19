import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseDatos {
  static final BaseDatos _instancia = BaseDatos._inicializar();

  Database? _baseDatos;

  BaseDatos._inicializar();

  factory BaseDatos() {
    return _instancia;
  }

  Future<Database> obtenerBaseDatos() async {
    if (_baseDatos != null) {
      return _baseDatos!;
    }
    final String rutaDirectorioBDs = await getDatabasesPath();
    final String rutaArchivoBD = join(rutaDirectorioBDs, "lista_tareas.sqlite");

    _baseDatos = await openDatabase(
      rutaArchivoBD,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE platos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            foto TEXT,
            precio REAL,
            diasDisponibles TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE clientes (
            cedula INTEGER PRIMARY KEY,
            nombre TEXT,
            direccion TEXT,
            telefono TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE pedidos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clienteId INTEGER,
            fechaHora TEXT,
            observaciones TEXT,
            estado TEXT, 
            cobrado INTEGER,  
            FOREIGN KEY(clienteId) REFERENCES clientes(cedula)
          );
        ''');

        await db.execute('''
          CREATE TABLE detallesPedidos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pedidoId INTEGER,
            platoId INTEGER,
            cantidad INTEGER,
            FOREIGN KEY(pedidoId) REFERENCES pedidos(id),
            FOREIGN KEY(platoId) REFERENCES platos(id)
          );
        ''');

        await db.execute('''
          CREATE TABLE pagos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pedidoId INTEGER,
            monto REAL,
            estado TEXT,
            FOREIGN KEY(pedidoId) REFERENCES pedidos(id)
          );
        ''');

        await db.execute('''
          INSERT INTO platos (nombre, foto, precio, diasDisponibles) VALUES
            ('Ensalada César', 'ensalada_cesar.jpg', 350.00, 'Lunes, Martes, Miércoles'),
            ('Sándwich de Pollo', 'sandwich_pollo.jpg', 250.00, 'Lunes, Jueves, Viernes'),
            ('Pizza Margherita', 'pizza_margherita.jpg', 450.00, 'Miércoles, Viernes, Sábado'),
            ('Hamburguesa Completa', 'hamburguesa_completa.jpg', 500.00, 'Martes, Jueves, Sábado');
        ''');

        await db.execute('''
          INSERT INTO clientes (cedula, nombre, direccion, telefono) VALUES
            (12345678, 'Juan Pérez', 'Av. Libertador 1234, Montevideo', '091234567'),
            (87654321, 'María Gómez', 'Calle Falsa 5678, Montevideo', '099876543'),
            (13579246, 'Carlos Ruiz', 'Bulevar Artigas 2345, Montevideo', '092345678'),
            (24681357, 'Ana López', 'Ruta 8 km 22, Canelones', '094567890');
        ''');

        await db.execute('''
          INSERT INTO pedidos (clienteId, fechaHora, observaciones, estado, cobrado) VALUES
            (12345678, '2024-12-18 08:00:00', 'Sin cebolla', 'Pendiente', 0),
            (87654321, '2024-12-18 08:30:00', 'Extra salsa', 'Pendiente', 1),
            (13579246, '2024-12-18 09:00:00', 'Sin tomate', 'Entregado', 1),
            (24681357, '2024-12-18 09:30:00', 'Aguantar hasta el mediodía', 'Cancelado', 0);
        ''');

        await db.execute('''
          INSERT INTO detallesPedidos (pedidoId, platoId, cantidad) VALUES
            (1, 1, 2),  -- Pedido 1: 2 Ensaladas César
            (2, 2, 1),  -- Pedido 2: 1 Sándwich de Pollo
            (3, 3, 3),  -- Pedido 3: 3 Pizzas Margherita
            (4, 4, 1);  -- Pedido 4: 1 Hamburguesa Completa
        ''');

        await db.execute('''
          INSERT INTO pagos (pedidoId, monto, estado) VALUES
            (1, 700.00, 'Pagado'),  
            (2, 250.00, 'Pendiente');
        ''');
      },
      onOpen: (db) {
        db.execute('PRAGMA foreign_keys = ON;');
      },
    );

    return _baseDatos!;
  }

  Future<void> cerrarBaseDatos() async {
    await _baseDatos?.close();
    _baseDatos = null;
  }
}
