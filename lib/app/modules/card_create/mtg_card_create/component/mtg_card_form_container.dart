import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/helpers.dart';

import '../../../../global_widgets/custom_edittext.dart';
import '../../../../global_widgets/helper_text.dart';
import '../controller/mtg_card_create_controller.dart';

class MtgCardFromContainer extends GetView<MtgCreateCardController> {
  const MtgCardFromContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.key,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                controller.firstNameController,
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
              child: HelperText().normalText("Location"),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomEditText().boxEditText(
                controller.locationController,
                '',
                "Location",
                Helper.noValidation,
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
                boxTextFieldColor),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: HelperText().normalText("Bio"),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomEditText().boxEditText(
                controller.bioController,
                '',
                "Bio",
                Helper.noValidation,
                TextInputType.text,
                boxTextFieldColor),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 45,
                child: Obx(() => controller.isLoading.value
                    ? const PageLoader()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor,
                            foregroundColor: AppColors.white,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          if (controller.key.currentState!.validate()) {
                            if (controller.coverImage.value == '') {
                              Helper.toastMsg("Choose a cover image!");
                              return;
                            }
                            if (controller.profileImage.value == '') {
                              Helper.toastMsg("Choose a profile photo!");
                              return;
                            }
                            if (controller.logoImage.value == '') {
                              Helper.toastMsg("Choose your company logo!");
                              return;
                            }
                            controller.createCard();

                            // Utils.loadingDialog(context);
                            // Future.delayed(const Duration(seconds: 2)).then((value) {
                            //   Utils.closeDialog(context);
                            //   showDialog(
                            //       context: context,
                            //       builder: (_) => AlertDialog(
                            //         content: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Row(
                            //               children: const [
                            //                 Icon(Icons.check_circle, color: Colors.green,),
                            //                 Text("Successfully Created Your Card"),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //   );
                            // });
                          }
                        },
                        child: const Text("Create"),
                      )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // const Divider(
            //   color: Colors.black54,
            // ),
          ],
        ),
      ),
    );
  }
}
