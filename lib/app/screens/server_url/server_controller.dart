import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/app/utils/constant.dart';

import '../../../data/repository/helpers/auth/is_auth.dart';

class ServerController extends Controller {
  final TextEditingController _urlController;
  TextEditingController? get urlController => _urlController;

  ServerController() : _urlController = TextEditingController();
  @override
  void initListeners() async {
    Constant.configLoading();
    _urlController.text = await IsAuth.getData('url');
  }

  void save() async {
    await storage.delete(key: "url");
    await IsAuth.setToken(key: 'url', value: _urlController.text);
    await EasyLoading.showSuccess('Successfully updated');
    Future.delayed(const Duration(milliseconds: 2250)).then((value) {
      Navigator.pop(getContext());
    });
  }

  @override
  void onDisposed() {
    _urlController.dispose();
    super.onDisposed();
  }
}
