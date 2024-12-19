class Cliente {
  final int cedula;
  final String nombre;
  final String direccion;
  final String telefono;

  Cliente({
    required this.cedula,
    required this.nombre,
    required this.direccion,
    required this.telefono,
  });

  factory Cliente.fromMap(Map<String, Object?> mapa) {
    return Cliente(
      cedula: mapa['cedula'] as int,
      nombre: mapa['nombre'] as String,
      direccion: mapa['direccion'] as String,
      telefono: mapa['telefono'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}
