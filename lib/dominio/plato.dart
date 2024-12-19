class Plato {
  final int id;
  final String nombre;
  final String foto;
  final double precio;
  final String diasDisponibles;

  Plato({
    required this.id,
    required this.nombre,
    required this.foto,
    required this.precio,
    required this.diasDisponibles,
  });

  factory Plato.fromMap(Map<String, Object?> mapa) {
    return Plato(
      id: mapa['id'] as int,
      nombre: mapa['nombre'] as String,
      foto: mapa['foto'] as String,
      precio: mapa['precio'] as double,
      diasDisponibles: mapa['diasDisponibles'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'foto': foto,
      'precio': precio,
      'diasDisponibles': diasDisponibles,
    };
  }
}
