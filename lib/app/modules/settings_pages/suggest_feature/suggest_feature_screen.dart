import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/modules/settings_pages/suggest_feature/controllers/suggest_feature_controller.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/values/colors.dart';
import '../../../data/enums/state_status.dart';
import '../../../global_widgets/custom_edittext.dart';

class SuggestFeatureScreen extends GetView<SuggestFeatureController> {
  const SuggestFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Suggest A Feature",
          style: TextStyle(color: Colors.black87),
        ),
        foregroundColor: Colors.black87,
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    const Text(
                        "Do you have an idea for a feature that would make better for you? Let us know!"),
                    const SizedBox(
                      height: 8,
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
                        boxTextFieldColor,
                        maxLines: 5),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(() => controller.stateStatus == StateStatus.LOADING
                        ? const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
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
                                  Utils.closeKeyBoard(context);
                                  controller.postSuggestFeature();
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
      ),
    );
  }
}
