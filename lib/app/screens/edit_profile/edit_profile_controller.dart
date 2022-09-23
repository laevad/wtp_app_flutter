import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wtp_app/app/screens/edit_profile/edit_profile_presenter.dart';

import '../../../domain/entities/user.dart';
import '../../utils/constant.dart';

class EditProfileController extends Controller {
  final EditProfilePresenter presenter;
  File? _image;
  File? get image => _image;

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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      _image = img;
      print("dfddddddddddddddddfffffffffffffffffffffffffffffffffffff");
      print(img);
      // Navigator.of(getContext()).pop();
      refreshUI();
    } on PlatformException catch (e) {
      print(e);
      // Navigator.of(getContext()).pop();
    }
    refreshUI();
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  void onDisposed() {
    presenter.dispose();
    _nameController!.dispose();
    _avatarUrlController!.dispose();
    _avatarController!.dispose();
    _emailController!.dispose();
    super.onDisposed();
  }
}
