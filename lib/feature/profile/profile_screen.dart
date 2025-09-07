import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? path;
  bool dark = false;
  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = LocalHelper.getData(LocalHelper.KName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: dark
                ? Icon(Icons.bedtime, color: AppColors.primarycolor)
                : Icon(Icons.light_mode, color: AppColors.primarycolor),
            onPressed: () {
              setState(() {
                dark = !dark;
                LocalHelper.cacheData(LocalHelper.KDark, dark);
              });
            },
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
                GestureDetector(
                  onTap: () {
                    showUploadbottomsheet(context);
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(
                          File(LocalHelper.getData(LocalHelper.KImage)),
                        ),
                        backgroundColor: AppColors.primarycolor,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor:
                              (LocalHelper.getData(LocalHelper.KDark)) ?? false
                              ? AppColors.darkcolor
                              : AppColors.white,
                          radius: 15,
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.primarycolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(30),
                Divider(color: AppColors.primarycolor),
                Gap(30),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocalHelper.getData(LocalHelper.KName),
                        style: TextStyles.getTitle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: AppColors.primarycolor,
                        ),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primarycolor,
                          width: 1,
                        ),
                        color:
                            ((LocalHelper.getData(LocalHelper.KDark)) ?? false
                            ? AppColors.darkcolor
                            : AppColors.white),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.mode_edit_outline,
                          color: AppColors.primarycolor,
                        ),
                        onPressed: () {
                          TextEditBottomSheet(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showUploadbottomsheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: (LocalHelper.getData(LocalHelper.KDark)) ?? false
                ? AppColors.darkcolor
                : AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainButton(
                title: 'Upload from Camera',
                onPressed: () {
                  UploadImage(true);
                },
              ),
              Gap(15),
              MainButton(
                title: 'Upload from Gallery',
                onPressed: () {
                  UploadImage(false);
                },
              ),
              Gap(15),
            ],
          ),
        );
      },
    );
  }

  TextEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (LocalHelper.getData(LocalHelper.KDark)) ?? false
                  ? AppColors.darkcolor
                  : AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController),
                Gap(15),
                MainButton(
                  title: 'Update Your Name',
                  onPressed: () {
                    setState(() {
                      LocalHelper.cacheData(
                        LocalHelper.KName,
                        nameController.text,
                      );
                      context.pop();
                    });
                  },
                ),
                Gap(15),
              ],
            ),
          ),
        );
      },
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
        LocalHelper.cacheData(LocalHelper.KImage, path);
      });
      context.pop(ProfileScreen());
    }
  }
}
