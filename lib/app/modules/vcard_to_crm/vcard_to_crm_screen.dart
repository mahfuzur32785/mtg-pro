import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/vcard_to_crm/controller/vcard_to_crm_controller.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/helpers.dart';
import '../../core/values/colors.dart';
import '../../global_widgets/custom_edittext.dart';
import '../../global_widgets/helper_text.dart';

class VCardToCrmScreen extends GetView<VCardToCrmController> {
  const VCardToCrmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar().simpleAppBar("Save To CRM"),
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Name"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.nameController,
                          '',
                          "Name",
                          Helper.validationAverage,
                          TextInputType.text,
                          boxTextFieldColor),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Email"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.emailController,
                          '',
                          "Email",
                          Helper.validationAverage,
                          TextInputType.emailAddress,
                          boxTextFieldColor),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Phone"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.phoneController,
                          '',
                          "Phone",
                          Helper.validationAverage,
                          TextInputType.number,
                          boxTextFieldColor),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Location"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.addressController,
                          '',
                          "Location",
                          Helper.validationAverage,
                          TextInputType.text,
                          boxTextFieldColor),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Job Title"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.jobTitleController,
                          '',
                          "Job Title",
                          Helper.noValidation,
                          TextInputType.text,
                          boxTextFieldColor),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Company"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomEditText().boxEditText(
                          controller.companyController,
                          '',
                          "Company",
                          Helper.noValidation,
                          TextInputType.text,
                          inputAction: TextInputAction.done,
                          boxTextFieldColor),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.grey.withOpacity(0.2),
            //       blurRadius: 6,
            //       offset: const Offset(0, 1)
            //   ),
            //   BoxShadow(
            //       color: Colors.grey.withOpacity(0.2),
            //       blurRadius: 6,
            //       offset: const Offset(0, 1)
            //   ),
            // ]
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: SizedBox(
              height: 45,
              child: Obx(() => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                          backgroundColor: AppColors.mainColor),
                      onPressed: () {
                        // print("${controller.isPhoneNumber("01860141942")}");
                        // return;
                        if (controller.formKey.currentState!.validate()) {
                          controller.formKey.currentState!.save();
                          controller.saveToCrm();
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(),
                      ),
                    )),
            ),
          ),
        ));
  }
}
