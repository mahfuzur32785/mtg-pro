import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/settings_pages/account_settings/controller/account_setting_controlller.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/values/colors.dart';
import '../../../data/enums/state_status.dart';
import '../../../global_widgets/custom_edittext.dart';

class AccountSettingScreen extends GetView<AccountSettingController> {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account Setting",
          style: TextStyle(color: Colors.black87),
        ),
        foregroundColor: Colors.black87,
      ),
      body: Obx(() => controller.stateStatus == StateStatus.LOADING
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              HelperText().headline("Notification"),
                              const SizedBox(
                                width: 16,
                              ),
                              Switch(
                                  value: controller.notification.value,
                                  onChanged: (value) {
                                    controller.notification.value = value;
                                    controller.postIsNotify();
                                  })
                            ],
                          ),
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
                                                  alignment: Alignment.center,
                                                      children: [
                                                        CustomImage(
                                                            path: controller
                                                                .profileUrl.value),
                                                        FaIcon(
                                                            FontAwesomeIcons
                                                                .camera,size: 30,color: Colors.black54,),
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
                            child: CustomEditText().borderEditText(
                                controller.emailController,
                                '',
                                "Email",
                                Helper.validationEmail,
                                TextInputType.emailAddress,
                                Colors.white),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    HelperText().normalText("Connection Title"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().borderEditText(
                                controller.connectionTitleController,
                                '',
                                "Connection Title",
                                Helper.validationAverage,
                                TextInputType.text,
                                Colors.white),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Username"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().borderEditText(
                                controller.usernameController,
                                '',
                                "Username",
                                Helper.validationAverage,
                                TextInputType.text,
                                Colors.white,
                                readOnly: true),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HelperText().normalText("Disclaimer"),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: CustomEditText().borderEditText(
                                controller.textAreaController,
                                '',
                                "User Disclaimer",
                                Helper.validationAverage,
                                TextInputType.text,
                                Colors.white,
                                maxLines: 5,
                                inputAction: TextInputAction.done),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: AppColors.mainColor),
                                  onPressed: () {
                                    if (!controller.formKey.currentState!.validate()) {
                                      return;
                                    }
                                    controller.updateProfile();
                                  },
                                  child: const Text("Save"),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: AppColors.mainColor),
                                  onPressed: () {
                                    controller.resetPasswordLink();
                                  },
                                  child: const Text("Reset Password"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red)),
                                onPressed: () {
                                  showDeleteDialog(context);
                                },
                                child: const Text("Account Delete"),
                              ),
                              // Expanded(
                              //   child:
                              // ),
                              // SizedBox(width: 16,),
                              // const Expanded(
                              //   child: SizedBox()
                              // ),
                            ],
                          ),


                          Wrap(
                            spacing: 10,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            runSpacing: 10,
                            direction: Axis.horizontal,
                            children: [

                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
    );
  }

  void showDeleteDialog(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 3,
        // isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        builder: (context) {
          var deleteController = TextEditingController();
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              minChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return CustomScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Center(
                          child: Container(
                            height: 5,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HelperText().boldText18("Confirm Account Deletion"),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Type 'delete' in Input box to delete your account.",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "All contacts and other data associated with this account will be permanently deleted. This cannot be undone.",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // CustomEditText().boxEditText(deleteController, '', "type 'delete' to delete account",
                          //     Helper.validationAverage, TextInputType.text, Colors.white),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: deleteController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 13),
                                hintText: "type 'delete' to delete account",
                                hintStyle: TextStyle(
                                    color: AppColors.ashTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(
                                        color: Colors.black87)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(
                                        color: Colors.black54)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: const BorderSide(
                                        color: Colors.black87)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 45,
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: AppColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                  onPressed: () {
                                    if (deleteController.text == '' ||
                                        deleteController.text != 'delete') {
                                      Helper.toastMsg(
                                          "type 'delete' in input box");
                                      return;
                                    }
                                    Navigator.pop(context);
                                    controller.deleteAccount();
                                  },
                                  child: const Text("Delete Account"),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                    ),
                  ],
                );
              });
        });
  }
}
