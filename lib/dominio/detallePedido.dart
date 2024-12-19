class DetallePedido {
  final int id;
  final int pedidoId;
  final int platoId;
  final int cantidad;
  final double precio;

  DetallePedido({
    required this.id,
    required this.pedidoId,
    required this.platoId,
    required this.cantidad,
    required this.precio,
  });

  factory DetallePedido.fromMap(Map<String, Object?> mapa) {
    return DetallePedido(
      id: mapa['id'] as int,
      pedidoId: mapa['pedidoId'] as int,
      platoId: mapa['platoId'] as int,
      cantidad: mapa['cantidad'] as int,
      precio: mapa['precio'] as double,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'pedidoId': pedidoId,
      'platoId': platoId,
      'cantidad': cantidad,
      'precio': precio,
    };
  }
}
