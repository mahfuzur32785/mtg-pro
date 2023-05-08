import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/global_widgets/custom_edittext.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/signup/signup_controller.dart';
import 'package:mtgpro/app/modules/signup/signup_navbar.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../global_widgets/page_loader.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 24),
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
                  key: controller.signupKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: HelperText().headingText("Sign Up"),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      HelperText().redNormalText("Full Name"),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.nameController,
                          controller.name,
                          "Full Name",
                          Helper.validationAverage,
                          TextInputType.name,ashColor),
                      const SizedBox(
                        height: 16,
                      ),
                      HelperText().redNormalText("Email Address"),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.emailController,
                          controller.email,
                          "Email Address",
                          Helper.validationEmail,
                          TextInputType.emailAddress,ashColor),
                      const SizedBox(
                        height: 26,
                      ),
                      HelperText().redNormalText("Username"),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.userNameController,
                          controller.userName,
                          "Username",
                          Helper.validationAverage,
                          TextInputType.name,ashColor),
                      const SizedBox(
                        height: 16,
                      ),
                      HelperText().redNormalText("Password"),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
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
                        ),
                      ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      HelperText().redNormalText("Confirm Password"),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: TextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password field is required!';
                            } else if (value.length < 8) {
                              return 'Enter minimum 8 digit';
                            } else if (value != controller.passwordController.text) {
                              return 'Does\'nt match with password';
                            }   else {
                              return null;
                            }
                          },
                          controller: controller.confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.obscureText.value,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          onSaved: (String? val) {
                            controller.confirmPassword = val;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ashColor,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 13),
                            hintText: 'Confirm Password*',
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
                        ),
                      )
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
                                  if (controller.signupKey.currentState!
                                      .validate()) {
                                    controller.signupKey.currentState!.save();
                                    controller.register();
                                    // Utils.loadingDialog(context);
                                    // Future.delayed(const Duration(seconds: 2)).then((value) {
                                    //   Utils.closeDialog(context);
                                    //   Helper.toastMsg("Successfully created Your Account!");
                                    // });

                                  }
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SignupNavBar(),
    );
  }
}
