import '../../entities/trip.dart';

abstract class TripRepository {
  Future<TripModel> getAllTrip(int page, String tripStatus);
  Future updateStatus(String bookingId, int statusId);
}
