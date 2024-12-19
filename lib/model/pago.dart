class Pago {
  final int id;
  final int pedidoId;
  final double monto;
  final String estado;

  Pago(
      {required this.id,
      required this.pedidoId,
      required this.monto,
      required this.estado});
}
