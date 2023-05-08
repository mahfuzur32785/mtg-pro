import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/global_widgets/custom_edittext.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/login/login_bottom_navbar.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../core/utils/constants.dart';
import '../../global_widgets/page_loader.dart';
import 'component/social_buttons.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 34),
              sliver: SliverToBoxAdapter(
                  child: Image(
                image: AssetImage(KImages.logo),
                height: 100,
              )),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Form(
                  key: controller.loginKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HelperText().headingText("Sign In"),
                      HelperText()
                          .normalText("Hi there! Nice to see you again."),
                      const SizedBox(
                        height: 16,
                      ),
                      HelperText().redNormalText("Email Address"),
                      // CustomEditText().normalEditText(
                      //     controller.emailController,
                      //     controller.email,
                      //     "Email",
                      //     Helper.validationEmail,
                      //     TextInputType.emailAddress),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(controller.emailController,
                          controller.email,
                          "Email",
                          Helper.validationEmail,
                          TextInputType.emailAddress, ashColor),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
                      //   child: TextFormField(
                      //     validator: Helper.validationEmail,
                      //     controller: controller.emailController,
                      //     textInputAction: TextInputAction.next,
                      //     keyboardType: TextInputType.emailAddress,
                      //     // inputFormatters: [
                      //     //   FilteringTextInputFormatter.digitsOnly
                      //     // ],
                      //     maxLines: 1,
                      //     onSaved: (String? val) {
                      //       controller.email = val;
                      //     },
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      //       hintText: 'Email',
                      //       // labelText: 'Email',
                      //       // isDense: true,
                      //       border: OutlineInputBorder(
                      //         borderRadius: borderRadius,
                      //         borderSide: const BorderSide(color: ashColor),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: borderRadius,
                      //         borderSide: const BorderSide(color: ashColor),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius: borderRadius,
                      //         borderSide: const BorderSide(color: ashColor),
                      //       ),
                      //       errorBorder: OutlineInputBorder(
                      //           borderRadius: borderRadius,
                      //           borderSide: const BorderSide(color: Colors.red)
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      HelperText().redNormalText("Password"),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
                        child: Obx(() {
                            return TextFormField(
                              validator: Helper.validationPassword,
                              controller: controller.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: controller.obscureText.value,
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              onSaved: (String? val) {
                                controller.password = val;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ashColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 13),
                                hintText: 'Password*',
                                hintStyle: TextStyle(
                                    color: AppColors.ashTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                                // labelText: 'Password*',
                                isDense: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.toggle();
                                  },
                                  icon: controller.obscureText.value
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(color: Colors.transparent)
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(color: Colors.red)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(color: Colors.transparent)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(color: Colors.transparent)
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: Obx(() => controller.isLoading.value
                            ? const Center(
                                child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator()))
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6))),
                                onPressed: () {
                                  if (controller.loginKey.currentState!
                                      .validate()) {
                                    controller.loginKey.currentState!.save();
                                    Utils.closeKeyBoard(context);
                                    controller.login();
                                    // Helper.toastMsg("${controller.email},${controller.password}");
                                    // Utils.loadingDialog(context);
                                    // Future.delayed(
                                    //         const Duration(milliseconds: 3000))
                                    //     .then((value) {
                                    //   Utils.closeDialog(context);
                                    //   MySharedPreference.cacheIsLoggedIn();
                                    //   Helper.toastMsg(
                                    //       "${controller.emailController.text},${controller.passwordController.text}");
                                    //   Get.offAndToNamed(Routes.stepVCardsName);
                                    // });
                                  }
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Align(
                        alignment: Alignment.center,
                          child: TextButton(onPressed: (){
                            Get.toNamed(Routes.forgotPass);
                          }, child: const Text("Forgot Password?")))

                      // const SocialButtons()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const LoginBottomNavBar(),
    );
  }
}

class LoginScreenOld extends StatelessWidget {
  const LoginScreenOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(Get.find()),
      builder: (controller) {
        return ModalProgressHUD(
            progressIndicator: const PageLoader(),
            inAsyncCall: controller.isLoading.value,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 34),
                      sliver: SliverToBoxAdapter(
                          child: Image(
                        image: AssetImage(KImages.logoFull),
                        height: 60,
                      )),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      sliver: SliverToBoxAdapter(
                        child: Form(
                          key: controller.loginKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().headingText("Sign In"),
                              HelperText().normalText(
                                  "Hi there! Nice to see you again."),
                              const SizedBox(
                                height: 16,
                              ),
                              HelperText().redNormalText("Email Address"),
                              CustomEditText().normalEditText(
                                  controller.emailController,
                                  controller.email,
                                  "Email",
                                  Helper.validationEmail,
                                  TextInputType.emailAddress),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(horizontal: 0),
                              //   child: TextFormField(
                              //     validator: Helper.validationEmail,
                              //     controller: controller.emailController,
                              //     textInputAction: TextInputAction.next,
                              //     keyboardType: TextInputType.emailAddress,
                              //     // inputFormatters: [
                              //     //   FilteringTextInputFormatter.digitsOnly
                              //     // ],
                              //     maxLines: 1,
                              //     onSaved: (String? val) {
                              //       controller.email = val;
                              //     },
                              //     decoration: InputDecoration(
                              //       filled: true,
                              //       fillColor: Colors.white,
                              //       contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                              //       hintText: 'Email',
                              //       // labelText: 'Email',
                              //       // isDense: true,
                              //       focusedBorder: UnderlineInputBorder(
                              //         borderSide: BorderSide(color: AppColors.textColor),
                              //       ),
                              //       errorBorder: UnderlineInputBorder(
                              //         borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
                              //       ),
                              //       border: UnderlineInputBorder(
                              //         borderSide: BorderSide(color: AppColors.ashTextColor),
                              //       ),
                              //       enabledBorder: UnderlineInputBorder(
                              //         borderSide: BorderSide(color: AppColors.ashTextColor),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 16,
                              ),
                              HelperText().redNormalText("Password"),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  validator: Helper.validationPassword,
                                  controller: controller.passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: controller.obscureText.value,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 1,
                                  onSaved: (String? val) {
                                    controller.password = val;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    hintText: 'Password*',
                                    hintStyle: TextStyle(
                                        color: AppColors.ashTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                    // labelText: 'Password*',
                                    isDense: true,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.toggle();
                                      },
                                      icon: controller.obscureText.value
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.black54,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.black54,
                                            ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.textColor),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.7)),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.ashTextColor),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.ashTextColor),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                  onPressed: () {
                                    if (controller.loginKey.currentState!
                                        .validate()) {
                                      controller.loginKey.currentState!.save();
                                      // Helper.toastMsg("${controller.email},${controller.password}");
                                      Utils.loadingDialog(context);
                                      Future.delayed(const Duration(
                                              milliseconds: 3000))
                                          .then((value) {
                                        Utils.closeDialog(context);
                                        MySharedPreference.cacheIsLoggedIn();
                                        Helper.toastMsg(
                                            "${controller.emailController.text},${controller.passwordController.text}");
                                        Get.offAndToNamed(
                                            Routes.stepVCardsName);
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                              const SocialButtons()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: const LoginBottomNavBar(),
            ));
      },
    );
  }
}
