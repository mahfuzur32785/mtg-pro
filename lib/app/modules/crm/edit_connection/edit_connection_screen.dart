import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mtgpro/app/modules/crm/edit_connection/edit_connection_controller.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/colors.dart';
import '../../../data/enums/state_status.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../../global_widgets/custom_image.dart';
import '../../../global_widgets/helper_text.dart';

class EditConnectionScreen extends GetView<EditConnectionController> {
  const EditConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.stateStatus == StateStatus.LOADING
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    "Edit Connection",
                    style: TextStyle(color: AppColors.mainColor),
                  ),
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white),
                  elevation: 0,
                  titleSpacing: 0,
                  pinned: true,
                  leading: IconButton(
                    onPressed: () {
                      Get.back(result: [
                        {"backValue": controller.isSuccess.value}
                      ]);
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.mainColor),
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  width: 170,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 4,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside),
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
                                      child: Obx(() => controller.image.value ==
                                              ''
                                          ? Material(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.white,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                hoverColor: Colors.white70,
                                                onTap: () {
                                                  controller.chooseImage();
                                                },
                                                child: Obx(() => controller
                                                            .profileUrl.value !=
                                                        ''
                                                    ? Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          CustomImage(
                                                              path: controller
                                                                  .profileUrl
                                                                  .value),
                                                          const FaIcon(
                                                            FontAwesomeIcons
                                                                .camera,
                                                            size: 30,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ],
                                                      )
                                                    : Center(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .image),
                                                            Text(
                                                                "Choose Profile")
                                                          ],
                                                        ),
                                                      )),
                                              ),
                                            )
                                          : Image(
                                              image: FileImage(
                                                File(controller.image.value),
                                              ),
                                              fit: BoxFit.cover,
                                            ))),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 50,
                                  child: Visibility(
                                    visible: controller.image.value != '',
                                    child: Material(
                                      color:
                                          AppColors.mainColor.withOpacity(0.6),
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          controller.editImage();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.edit,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  left: 50,
                                  child: Visibility(
                                    visible: controller.image.value != '',
                                    child: Material(
                                      color:
                                          AppColors.mainColor.withOpacity(0.6),
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          controller.deleteImage();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 16,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Name"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().boxEditText(
                                controller.nameController,
                                '',
                                "Name",
                                Helper.validationAverage,
                                TextInputType.text,
                                ashColor,
                                readOnly: false),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Email"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().boxEditText(
                                controller.emailController,
                                '',
                                "Email",
                                Helper.validationAverage,
                                TextInputType.emailAddress,
                                ashColor),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Phone"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().boxEditText(
                                controller.phoneController,
                                '',
                                "Phone",
                                Helper.validationAverage,
                                TextInputType.text,
                                ashColor),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Job title"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().boxEditText(
                              controller.jobTitleController,
                              '',
                              "Job title",
                              Helper.validationAverage,
                              TextInputType.text,
                              ashColor,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Company Name"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().boxEditText(
                              controller.companyNameController,
                              '',
                              "Company Name",
                              Helper.validationAverage,
                              TextInputType.text,
                              ashColor,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Description"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().boxEditText(
                              controller.descriptionController,
                              '',
                              "Description",
                              Helper.validationAverage,
                              TextInputType.text,
                              ashColor,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mainColor,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                if (!controller.formKey.currentState!
                                    .validate()) {
                                  return;
                                }
                                controller.updateCrmDetails(
                                    controller.argumentData[0]);
                              },
                              child: const Text("Update"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ));
  }
}
