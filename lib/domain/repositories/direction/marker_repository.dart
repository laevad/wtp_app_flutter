abstract class MarkerRepository {
  Future addMarker(String bookingId, double latitude, double longitude);
  Future getMarkers(String bookingId);
}
