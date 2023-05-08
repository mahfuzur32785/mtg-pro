import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/modules/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../animation/delayed_animation.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.value ? const Center(
        child: CircularProgressIndicator(),
      ) : const Center(
        child: DelayedAnimation(
            delay: 600,
            child: Image(image: AssetImage(KImages.logo),height: 200,)),
      ),
      ),
    );
  }
}
