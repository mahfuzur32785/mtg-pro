import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/animation/custom_delayed_animation.dart';
import 'package:mtgpro/app/animation/delayed_animation.dart';
import 'package:mtgpro/app/animation/top_bottom_animation.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/welcome/welcome_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.mainColor,statusBarIconBrightness: Brightness.light),
    );

    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: AppColors.mainColor,
            body: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.antiAlias,
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: 0,
                  right: -20,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  // left: 40,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  right: 0,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  left: -60,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.6,
                  // left: -60,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ),
                DecoratedBox(
                  position: DecorationPosition.background,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.mainColor.withOpacity(0.93),
                          // AppColors.mainColor.withOpacity(0.93),
                          Colors.white,
                        ],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      )
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          const DelayedTopBottomAnimation(
                            delay: 200,
                              child: Image(image: AssetImage(KImages.logoFull),color: Colors.white,height: 50,)
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DelayedTopBottomAnimation(
                              delay: 250,
                              child: Text("Create a business card for \nevery situation.",
                                textAlign: TextAlign.center,style: TextStyle(color: AppColors.white,fontSize: 23,fontWeight: FontWeight.w300),),
                          ),
                          Expanded(
                            child: CustomDelayedAnimation(
                              delay: 400,
                              dx: 0.5,
                              dy: 0.0,
                              child: PageView(
                                controller: controller.pageController,
                                scrollDirection: Axis.horizontal,
                                // physics: const NeverScrollableScrollPhysics(),
                                onPageChanged: (index){
                                  controller.changePage(index);
                                  // controller.pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                },
                                children: [
                                  ...List.generate(3, (index){
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: controller.width * 0.2,vertical: controller.height * 0.07),
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.topCenter,
                                        fit: StackFit.loose,
                                        children: [
                                          // category top.............
                                          Positioned(
                                            top: -10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: controller.getColor(),
                                                borderRadius: BorderRadius.circular(30)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16,),
                                                child: Text(getTypeName(index),style: const TextStyle(color: Colors.white,fontSize: 12),),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -32,
                                            left: 45,
                                            right: 45,
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.4),
                                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -16,
                                            left: 24,
                                            right: 24,
                                            child: Container(
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.8),
                                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),),
                                              ),
                                            ),
                                          ),

                                          Stack(
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            alignment: Alignment.topCenter,
                                            fit: StackFit.loose,
                                            children: [
                                              // image.............
                                              Positioned(
                                                top: 30,
                                                child: Center(child: Image(image: const AssetImage("assets/images/default-user.png"),height: controller.height * 0.3,)),
                                              ),

                                              // .... Curve .........
                                              Positioned(
                                                bottom: 30,
                                                left: -60,
                                                right: -350,
                                                height: controller.height * 0.35,
                                                child: SvgPicture.asset(
                                                  fit: BoxFit.fill,
                                                  color: controller.getColor(),
                                                  "assets/images/wave_n_4.svg",),
                                              ),
                                              Positioned(
                                                bottom: 30,
                                                left: -60,
                                                right: -350,
                                                height: controller.height * 0.32,
                                                child: SvgPicture.asset(
                                                  fit: BoxFit.fill,
                                                  color: Colors.white,
                                                  "assets/images/wave_n_4.svg",),
                                              ),

                                              // text bottom.............
                                              Positioned(
                                                bottom: 0,
                                                left: 16,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      HelperText().boldText18("Any Awesome"),
                                                      HelperText().ashBoldText("Job Title"),
                                                      HelperText().normalText("Company"),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        height: 5,
                                                        decoration: BoxDecoration(
                                                            color: const Color(0xFFF4F4F4),
                                                            borderRadius: BorderRadius.circular(3)
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                ],
                              ),


                            ),
                          ),
                          DelayedAnimation(
                            delay: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              onPressed: (){
                                MySharedPreference.cacheOnBoarding().then((value) {
                                  Get.offAllNamed(Routes.login);
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 16),
                                child: Text("LOGIN",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),
                          DelayedAnimation(
                            delay: 250,
                            child: TextButton(
                              // style: ElevatedButton.styleFrom(primary: AppColors.mainColor,
                              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              onPressed: (){
                                MySharedPreference.cacheOnBoarding().then((value) {
                                  Get.offAllNamed(Routes.login);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 8),
                                child: Text("SIGNUP",style: TextStyle(color: AppColors.mainColor),),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getTypeName(index){
    if (index == 0) {
      return "Business";
    }
    if (index == 1) {
      return "Personal";
    }
    if (index == 2) {
      return "Work";
    }
    return "Work";
  }

}
