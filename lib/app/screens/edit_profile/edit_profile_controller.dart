import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/app/screens/edit_profile/edit_profile_presenter.dart';

import '../../../domain/entities/user.dart';
import '../../utils/constant.dart';

class EditProfileController extends Controller {
  final EditProfilePresenter presenter;

  final TextEditingController? _nameController;
  final TextEditingController? _emailController;
  final TextEditingController? _avatarController;
  final TextEditingController? _avatarUrlController;

  TextEditingController? get nameController => _nameController;
  TextEditingController? get emailController => _emailController;
  TextEditingController? get avatarController => _avatarController;
  TextEditingController? get avatarUrlController => _avatarUrlController;

  EditProfileController(userRepository)
      : presenter = EditProfilePresenter(userRepository),
        _nameController = TextEditingController(),
        _emailController = TextEditingController(),
        _avatarController = TextEditingController(),
        _avatarUrlController = TextEditingController(),
        super();
  @override
  void initListeners() {
    Constant.configLoading();
    EasyLoading.show(status: 'loading...');
    presenter.getUser();
    presenter.getUserOnNext = (User user) async {
      _nameController?.text = user.name!;
      _emailController?.text = user.email!;
      _avatarController?.text = user.avatar.toString();
      _avatarUrlController?.text = user.avatarUrl.toString();
      debugPrint("get user on next");
      refreshUI();
    };
    presenter.getUserOnError = (e) {
      debugPrint("get user on error: ${e.toString()}");
    };
    presenter.getUserOnComplete = () async {
      debugPrint("get user on complete");
      EasyLoading.dismiss();
      refreshUI();
    };
    refreshUI();
  }

  @override
  void onDisposed() {
    presenter.dispose();
    _nameController!.dispose();

    _emailController!.dispose();
    super.onDisposed();
  }
}
