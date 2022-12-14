import '../../entities/trip.dart';

abstract class TripRepository {
  Future<TripModel> getAllTrip(int page);
  Future<TripModel> getAllTripComplete(int page);
  Future updateStatus(String bookingId, int statusId);
}
