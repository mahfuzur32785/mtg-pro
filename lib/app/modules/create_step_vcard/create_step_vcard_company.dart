import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_vcard_controller.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/helpers.dart';
import '../../global_widgets/custom_edittext.dart';
import '../../global_widgets/helper_text.dart';
import '../../global_widgets/page_loader.dart';
import '../../routes/routes.dart';
import 'component/bottom_nav.dart';

class CreateStepVcardCompany extends GetView<CreateStepVcardController> {
  const CreateStepVcardCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar().createStepVcardAppBar(1),
      body: Obx(() => controller.isLoading.value ? const PageLoader() : Form(
        key: controller.companyFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HelperText().normalText("Job"),
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
              child: CustomEditText().boxEditText(controller.designationController, '', "Designation", Helper.noValidation, TextInputType.text,boxTextFieldColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HelperText().normalText("Company"),
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
              child: CustomEditText().boxEditText(
                controller.companyController,
                '', "Company",
                Helper.noValidation,
                TextInputType.text,
                inputAction: TextInputAction.done,
                boxTextFieldColor,
              ),
            ),
          ],
        ),
      )
      ),
      bottomNavigationBar: StepVCardsBottomNav(text: "Next",onPressed: (){
        if (controller.companyFormKey.currentState!.validate()) {
          Get.toNamed(Routes.stepVCardsPhoto);
        }
      }),
    );
  }
}
