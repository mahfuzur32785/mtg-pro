import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/modules/signup/signup_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';

class SmsVerificationScreen extends StatelessWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (controller){
        return ModalProgressHUD(
          progressIndicator: const PageLoader(),
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Icon(Icons.verified_user_rounded,size: 100,color: AppColors.mainColor,),
                          const SizedBox(
                            height: 50,
                          ),
                          HelperText().headingText("SMS Verification"),
                          HelperText().ashNormalCenterText("We have just sent 4 digit verification code \nto your ***62 mobile number"),
                          const SizedBox(
                            height: 50,
                          ),
                          Pinput(
                            controller: controller.pinController,
                            length: 4,
                            toolbarEnabled: true,
                            showCursor: true,
                            defaultPinTheme: controller.defaultPinTheme,
                            focusedPinTheme: controller.focusedPinTheme,
                            // obscureText: true,
                            useNativeKeyboard: true,
                            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                            onCompleted: (value){
                              controller.submitOtp(value);
                              if (kDebugMode) {
                                print(value);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HelperText().ashNormalText("Did not get SMS?"),
                              TextButton(
                                onPressed:  (){

                                },
                                child: Text("Resend Now",style: TextStyle(color: AppColors.mainColor),),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
