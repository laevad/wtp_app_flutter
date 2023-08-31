import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repository/expense/data_expense_repository.dart';
import '../../utils/constant.dart';
import 'add_expense_controller.dart';

class AddExpenseView extends CleanView {
  static String routeName = '/add-expense';
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  AddExpenseViewState createState() => AddExpenseViewState();
}

class AddExpenseViewState
    extends CleanViewState<AddExpenseView, AddExpenseController> {
  late var args;
  File? img;
  /*camera*/
  late CameraController cameraController;
  AddExpenseViewState() : super(AddExpenseController(DataExpenseRepository()));

  @override
  void didChangeDependencies() {
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
        as Map;
    super.didChangeDependencies();
  }

  Future _pickImage(ImageSource source) async {
    try {
      EasyLoading.show(status: 'loading...');

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        EasyLoading.dismiss();

        return;
      }
      EasyLoading.show(status: 'loading...');
      img = File(image.path);
      img = await _cropImage(imageFile: img!);
      print("===============================");
      print(img?.path);
      if (img == null) {
        EasyLoading.dismiss();
        return;
      } else {
        setState(() {
          EasyLoading.dismiss();
          // Navigator.pushNamed(context, AddExpenseView.routeName,
          //     arguments: {'image_path': img?.path, 'image': img});
        });
      }
    } on PlatformException catch (e) {
      print("================*********=========================");
      print(e);
      EasyLoading.dismiss();
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.original,
    ], sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget get view => ControlledWidgetBuilder<AddExpenseController>(
        builder: (context, controller) {
          if (img != null) {
            controller.setImagePath = img!.path;
          }
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              key: globalKey,
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Travel Expense Report'),
              ),
              body: controller.expenseType == null ||
                      controller.tripStartEnd == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Constant.lightColorScheme.primary,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  hint: const Text('Select Expense Type'),
                                  value: controller.selectedExpenseType,
                                  isExpanded: true,
                                  items: controller.expenseType!.map(
                                    (e) {
                                      return DropdownMenuItem(
                                        value: e.id.toString(),
                                        child: Text(e.name.toString()),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.setSelectedExpenseType =
                                          value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  hint: const Text('Select Trip'),
                                  isExpanded: true,
                                  value: controller.selectedTrip,
                                  items: controller.tripStartEnd!.map(
                                    (e) {
                                      return DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: e.id,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${e.id?.split("-")[0]} - ${e.dateCompleted}",
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.setSelectedTrip = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  controller: controller.amountTextController,
                                  decoration: InputDecoration(
                                    hintText: 'Amount',
                                    errorText: controller
                                                .expenseError?.amountError ==
                                            null
                                        ? null
                                        : controller.expenseError!.amountError
                                            .toString(),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  minLines: 2,
                                  maxLines: 5,
                                  controller:
                                      controller.descriptionTextController,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                    onPressed: () => setState(() {
                                          controller.addExpense();
                                        }),
                                    child: const Text(
                                      "Add Expense",
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ),
                            ),
                            /*show the cropped image*/
                            if (img != null)
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(img!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
              /*floating camera ang image picker*/
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text('Gallery'),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add_a_photo),
              ),
            ),
          );
        },
      );
}
