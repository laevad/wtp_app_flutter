abstract class UserLocationRepository {
  Future addLocation(double latitude, double longitude);
  Future updateStatus(String bookingId, int statusId);
}
