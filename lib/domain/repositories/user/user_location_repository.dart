abstract class UserLocationRepository {
  Future addLocation(double latitude, double longitude, int statusId);
  Future updateStatus(String bookingId, int statusId);
}
