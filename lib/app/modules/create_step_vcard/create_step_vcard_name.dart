import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/global_widgets/custom_edittext.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/create_step_vcard/component/bottom_nav.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_vcard_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../global_widgets/page_loader.dart';

class CreateStepVcardName extends GetView<CreateStepVcardController> {
  const CreateStepVcardName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar().createStepVcardAppBar(0),
      body: Obx(() => controller.isLoading.value ? const PageLoader() : Form(
        key: controller.nameFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: HelperText().boldText18("Create Your First Card",),
                )
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HelperText().normalText("Name"),
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
              child: CustomEditText().boxEditText(controller.nameController, 'abcdefg', "Name", Helper.validationAverage, TextInputType.text,boxTextFieldColor),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HelperText().normalText("Phone"),
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
              child: CustomEditText().boxEditText(controller.phoneController, '', "ex:+15162973389", Helper.validationPhone, TextInputType.number,boxTextFieldColor,inputAction: TextInputAction.done),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 16),
              child: SizedBox(
                child: HelperText().ashNormalText("Adding a phone number allows people to connect with you by text message or phone call"),
              ),
            ),
          ],
        ),
      )
      ),
      bottomNavigationBar: StepVCardsBottomNav(text: "Next",onPressed: (){
        if (controller.nameFormKey.currentState!.validate()) {
          Get.toNamed(Routes.stepVCardsCompany);
        }
      }),
    );
  }
}
