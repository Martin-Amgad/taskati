import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/feature/profile/profile_screen.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${(LocalHelper.getData(LocalHelper.KName) as String).split(' ')[0]}',
                style: TextStyles.getTitle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primarycolor,
                  fontSize: 22,
                ),
              ),
              Text(
                'Have a nice day',
                style: TextStyles.getSmall(
                  fontWeight: FontWeight.w500,

                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primarycolor,
          child: GestureDetector(
            onTap: () {
              context.pushTo(ProfileScreen()).then((value) {
                setState(() {});
              });
            },
            child: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(
                File(LocalHelper.getData(LocalHelper.KImage)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
