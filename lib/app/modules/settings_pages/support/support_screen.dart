import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/modules/settings_pages/support/controller/support_controller.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/values/colors.dart';
import '../../../data/enums/state_status.dart';
import '../../../global_widgets/custom_edittext.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Support",
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
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(-5, -5)),
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(5, 5)),
                        ]),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("To"),
                          const Text("support@mtgpro.me"),
                          const Divider(
                            height: 50,
                          ),
                          const Text("Subject*"),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomEditText().boxEditText(
                              controller.subjectController,
                              '',
                              'Subject',
                              Helper.validationAverage,
                              TextInputType.text,
                              boxTextFieldColor),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text("Message*"),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomEditText().boxEditText(
                              controller.messageController,
                              '',
                              'Message',
                              Helper.validationAverage,
                              TextInputType.text,
                              boxTextFieldColor),
                          const SizedBox(
                            height: 16,
                          ),
                          Obx(() => controller.btnLoading.value
                              ? const Center(
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : SizedBox(
                                  height: 48,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.mainColor,
                                        foregroundColor: Colors.white),
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.formKey.currentState?.save();
                                        // controller.changeBtnLoading(true);
                                        Utils.closeKeyBoard(context);
                                        controller.postSupport();

                                        // Future.delayed(
                                        //         const Duration(seconds: 2))
                                        //     .then((value) {
                                        //       Get.snackbar("Mailing","We have received your mail. our team contact with you very soon. thank you");
                                        //   controller.changeBtnLoading(false);
                                        //   controller.subjectController.text = '';
                                        //   controller.messageController.text = '';
                                        // });
                                      }
                                    },
                                    child: const Text("Send"),
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
    );
  }
}
