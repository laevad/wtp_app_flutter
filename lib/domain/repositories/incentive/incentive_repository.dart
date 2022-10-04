import 'package:wtp_app/domain/entities/incentive.dart';

abstract class IncentiveRepository {
  Future<IncentiveModel> getAllIncentive(int page);
}
