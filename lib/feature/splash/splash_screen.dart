import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/feature/home/pages/home_screen.dart';
import 'package:taskati/feature/upload/pages/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var IsUpload = LocalHelper.getData(LocalHelper.KIsUpload) ?? false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      //context.pushWithReplacement(UploadScreen());
      context.pushWithReplacement(IsUpload ? HomeScreen() : UploadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.logo),
            Text('Taskati', style: TextStyles.getBody(fontSize: 24)),
            Gap(15),
            Text('its\'s Time to Get Organised', style: TextStyles.getSmall()),
          ],
        ),
      ),
    );
  }
}
