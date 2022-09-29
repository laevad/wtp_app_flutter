import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/repositories/user/user_location_repository.dart';

import '../../data_constants.dart';
import '../helpers/auth/is_auth.dart';

class DataUserLocationRepository extends UserLocationRepository {
  @override
  Future addLocation(double latitude, double longitude) async {
    Map<String, dynamic> body = {
      'user_id': await IsAuth.getData("id"),
      'latitude': 12,
      'longitude': 23,
    };
    var response = await http.post(Uri.parse("$siteURL/user/location"),
        headers: await getHeader());
    print(response.body);
    throw UnimplementedError();
  }
}
