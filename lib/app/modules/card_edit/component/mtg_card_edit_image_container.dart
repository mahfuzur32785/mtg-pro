import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/modules/card_edit/controller/card_edit_controller.dart';

class MtgCardEditPictureContainer extends GetView<MtgCardEditController> {
  const MtgCardEditPictureContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenWidth(context) * 0.65,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: screenWidth(context),
              height: screenWidth(context) * 0.45,
              decoration: const BoxDecoration(color: Colors.white),
              child: Obx(() => controller.coverImage.value != ''
                  ? Image.file(File(controller.coverImage.value))
                  : CustomImage(path: controller.getCoverUrl(),
                fit: BoxFit.cover,)),
              // child: LayoutBuilder(
              //     builder: (context,constraints) {
              //       if (controller.coverImage != null) {
              //         return Image.file(File(controller.coverImage!));
              //       }
              //       return Image.asset("assets/images/background.jpg",fit: BoxFit.cover);
              //     }
              // )
            ),
          ),
          Positioned(
            right: 8,
            bottom: (screenWidth(context) * 0.2) + 8,
            child: Material(
              shape: const CircleBorder(),
              elevation: 3,
              color: blackColor.withOpacity(0.8),
              child: InkWell(
                onTap: () {
                  controller.chooseCoverImage();
                },
                borderRadius: BorderRadius.circular(50),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: FaIcon(
                    FontAwesomeIcons.camera,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth(context) * 0.4,
              height: screenWidth(context) * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white,
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignOutside),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 0)),
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 0)),
                  ]),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: screenWidth(context) * 0.4,
                    height: screenWidth(context) * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white,
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Obx(() => controller.profileImage.value != ''
                          ? Image.file(File(controller.profileImage.value))
                          : CustomImage(path: controller.getProfileUrl(),
                        fit: BoxFit.cover,)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: screenWidth(context) * 0.1,
                      height: screenWidth(context) * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 0)),
                          ]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() => controller.logoImage.value != ''
                                  ? Image.file(File(controller.logoImage.value))
                                  : CustomImage(path: controller.getLogoUrl(),)
                              ),
                              Material(
                                shape: const CircleBorder(),
                                elevation: 3,
                                color: blackColor.withOpacity(controller.logoImage.value != '' ? 0.2 : 0.3),
                                child: InkWell(
                                  onTap: () {
                                    controller.chooseLogoImage();
                                  },
                                  borderRadius: BorderRadius.circular(50),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: FaIcon(
                                      FontAwesomeIcons.camera,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      shape: const CircleBorder(),
                      elevation: 3,
                      color: blackColor.withOpacity(0.5),
                      child: InkWell(
                        onTap: () {
                          controller.chooseProfileImage();
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: FaIcon(
                            FontAwesomeIcons.camera,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
