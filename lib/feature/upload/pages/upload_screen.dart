import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/functions/dialogs.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/feature/home/pages/home_screen.dart';
import 'package:taskati/feature/task/task_dispaly_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (path != null && nameController.text.isNotEmpty) {
                LocalHelper.cacheData(LocalHelper.KIsUpload, true);
                LocalHelper.cacheData(LocalHelper.KName, nameController.text);
                LocalHelper.cacheData(LocalHelper.KImage, path);
                context.pushWithReplacement(HomeScreen());
              } else if (path == null && nameController.text.isNotEmpty) {
                showerrordialoge(context, 'please enter an image');
              } else if (path != null && nameController.text.isEmpty) {
                showerrordialoge(context, 'please enter a name');
              } else if (path == null && nameController.text.isEmpty) {
                showerrordialoge(context, 'please enter an image and a name');
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: path != null
                      ? FileImage(File(path ?? ''))
                      : AssetImage(AppAssets.defaultprofile),
                  backgroundColor: AppColors.primarycolor,
                ),
                Gap(20),
                MainButton(
                  width: 270,
                  title: 'Upload From Camera',
                  onPressed: () {
                    UploadImage(true);
                  },
                ),
                Gap(10),
                MainButton(
                  width: 270,
                  title: 'Upload From Gallery',
                  onPressed: () {
                    UploadImage(false);
                  },
                ),
                Gap(20),
                Divider(),
                Gap(20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter your name'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UploadImage(bool isCamera) async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }
}
