import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/forgot_password/controller/forgor_pass_controller.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/utils.dart';
import '../../core/values/colors.dart';
import '../../core/values/k_images.dart';
import '../../global_widgets/custom_edittext.dart';
import '../../global_widgets/helper_text.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar().simpleAppBar("Forgot Password"),
        body: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              sliver: SliverToBoxAdapter(
                  child: Image(
                image: AssetImage(KImages.logo),
                height: 200,
              )),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelperText().redNormalText("Email Address"),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomEditText().boxEditText(
                        controller.emailController,
                        '',
                        "Email",
                        Helper.validationEmail,
                        TextInputType.emailAddress,
                        ashColor),
                    const SizedBox(
                      height: 16,
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
                                      borderRadius: BorderRadius.circular(6))),
                              onPressed: () {
                                if (controller.emailController.text == "") {
                                  Helper.toastMsg("Enter Your Account's Email!");
                                  return;
                                }
                                if (!GetUtils.isEmail(controller.emailController.text)) {
                                  Helper.toastMsg("Enter valid email!");
                                  return;
                                }
                                Utils.closeKeyBoard(context);
                                controller.resetPasswordLink();
                              },
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
