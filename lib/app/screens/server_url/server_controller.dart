import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repository/helpers/auth/is_auth.dart';

class ServerController extends Controller {
  String? _url;
  String? get url => _url;

  @override
  void initListeners() async {
    _url = await IsAuth.getData('url');
  }
}
