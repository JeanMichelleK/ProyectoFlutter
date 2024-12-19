class Pedido {
  final int id;
  final int clienteCedula;
  final String fecha;
  final String estado;
  final double total;

  Pedido({
    required this.id,
    required this.clienteCedula,
    required this.fecha,
    required this.estado,
    required this.total,
  });

  factory Pedido.fromMap(Map<String, Object?> mapa) {
    return Pedido(
      id: mapa['id'] as int,
      clienteCedula: mapa['clienteCedula'] as int,
      fecha: mapa['fecha'] as String,
      estado: mapa['estado'] as String,
      total: mapa['total'] as double,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'clienteCedula': clienteCedula,
      'fecha': fecha,
      'estado': estado,
      'total': total,
    };
  }
}
