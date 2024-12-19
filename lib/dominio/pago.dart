class Pago {
  final int id;
  final int pedidoId;
  final String fecha;
  final double monto;
  final String metodo;

  Pago({
    required this.id,
    required this.pedidoId,
    required this.fecha,
    required this.monto,
    required this.metodo,
  });

  factory Pago.fromMap(Map<String, Object?> mapa) {
    return Pago(
      id: mapa['id'] as int,
      pedidoId: mapa['pedidoId'] as int,
      fecha: mapa['fecha'] as String,
      monto: mapa['monto'] as double,
      metodo: mapa['metodo'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'pedidoId': pedidoId,
      'fecha': fecha,
      'monto': monto,
      'metodo': metodo,
    };
  }
}
