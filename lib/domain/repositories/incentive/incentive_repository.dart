import '../../entities/incentive.dart';

abstract class IncentiveRepository {
  Future<IncentiveModel> getAllIncentive(int page);
}
