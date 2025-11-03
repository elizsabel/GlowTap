// ===== MODEL ORDER STATUS (untuk tracking) =====
class OrderStatus {
  final String status; // waiting, confirmed, on_the_way, arrived, ongoing
  final double doctorLat;
  final double doctorLng;

  OrderStatus({
    required this.status,
    required this.doctorLat,
    required this.doctorLng,
  });
}