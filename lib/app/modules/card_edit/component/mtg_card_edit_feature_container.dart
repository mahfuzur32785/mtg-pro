import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/card_edit/controller/card_edit_controller.dart';

import '../../../core/utils/helpers.dart';
import '../../../global_widgets/custom_edittext.dart';

class MtgCardEditExtraFeatureContainer extends GetView<MtgCardEditController> {
  const MtgCardEditExtraFeatureContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 1),
              blurRadius: 6,
            )
          ]),
      child: ExpandablePanel(
          header: const ListTile(
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            // trailing: Material(
            //   color: const Color(0xfff4f4f4),
            //   shape: const CircleBorder(),
            //   child: InkWell(
            //     borderRadius: BorderRadius.circular(50),
            //     onTap: () {
            //
            //     },
            //     child: const Padding(
            //       padding: EdgeInsets.all(12),
            //       child: Icon(
            //         Icons.qr_code_scanner,
            //         color: Colors.lightBlue,
            //       ),
            //     ),
            //   ),
            // ),
            title: Text(
              "Additional Features",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            style: ListTileStyle.drawer,
          ),
          collapsed: const SizedBox(),
          expanded: Column(
            children: [
              //........... E Q U A L  H O U S I N G  L O G O ............
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.house,
                      size: 24,
                      color: AppColors.mainColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Equal housing logo",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Equal housing logo show",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Obx(() {
                      return Switch(activeColor: AppColors.mainColor,value: controller.housingLogo.value, onChanged: (value) {
                        controller.changeHousingLogo(value);
                      });
                    }
                  ),
                ],
              ),
              //........... U S E R  D I S C L A I M E R............
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.noteSticky,
                      size: 24,
                      color: AppColors.mainColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "User Disclaimer",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "User Disclaimer Show",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Obx(() {
                      return Switch(activeColor: AppColors.mainColor,value: controller.disclaimer.value, onChanged: (value) {
                        controller.changeDisclaimer(value);
                      });
                    }
                  ),
                ],
              ),
              //........... U S E R  N M L S  I D............
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.addressCard,
                      size: 24,
                      color: AppColors.mainColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "User NMLS ID",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "User nmls Show",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Obx(() {
                      return Switch(activeColor: AppColors.mainColor,value: controller.nmls.value, onChanged: (value) {
                        controller.changeNmls(value);
                      });
                    }
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomEditText().boxEditText(
                  controller.nmlsController,
                  '',
                  'Nmls id',
                  Helper.validationAverage,
                  TextInputType.text,
                  boxTextFieldColor,
                  maxLines: 1),
              const SizedBox(
                height: 16,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Obx(() => controller.nmlsBtnLoading.value
                      ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: SizedBox(height: 24,width: 24,child: CircularProgressIndicator()),
                      )
                      : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40)),
                      onPressed: () {
                        if (controller.nmlsController.text != "") {
                          controller.addUserNmls();
                        } else {
                          Get.snackbar("Message", "Please Enter NMLS ID");
                        }
                      },
                      child: const Text("Save"))
                  )),
              const SizedBox(
                height: 16,
              ),
              //........... F O R M............
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.handHoldingDollar,
                      size: 24,
                      color: AppColors.mainColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Form",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Credit Authorization",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Obx(() {
                      return Switch(activeColor: AppColors.mainColor,value: controller.credit.value, onChanged: (value) {
                        controller.changeCredit(value);
                      });
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Quick Application",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Obx(() {
                      return Switch(activeColor: AppColors.mainColor,value: controller.quick.value, onChanged: (value) {
                        controller.changeQuick(value);
                      });
                    }
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
