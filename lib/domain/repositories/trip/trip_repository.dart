import '../../entities/trip.dart';

abstract class TripRepository {
  Future<TripModel> getAllTrip(int page);
  Future updateStatus();
}
