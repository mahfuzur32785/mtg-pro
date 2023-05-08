import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';
import 'package:mtgpro/app/modules/review/review_controller.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/helpers.dart';
import '../../core/values/k_images.dart';
import '../../data/enums/state_status.dart';
import '../../global_widgets/custom_edittext.dart';

class MyReviewScreen extends GetView<ReviewController> {
  MyReviewScreen({Key? key}) : super(key: key);

  final HomeCardsController homeCardsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Review",
          style: TextStyle(color: AppColors.mainColor),
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.mainColor),
        ),
      ),
      body: Obx(
        () => controller.stateStatus == StateStatus.LOADING
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  GetBuilder<ReviewController>(
                    builder: (reviewController) {
                      if (controller.reviewModel != null &&
                          !controller.isForm.value) {
                        return SliverToBoxAdapter(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage("${homeCardsController.userInfo?.profileImage}"),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(controller
                                              .reviewModel!.displayName),
                                          Text(
                                            controller
                                                .reviewModel!.displayTitle,
                                            style: const TextStyle(
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.readyToUpdate();
                                      },
                                      child: const FaIcon(
                                          FontAwesomeIcons.penToSquare),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        child: Divider(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: FaIcon(
                                          FontAwesomeIcons.quoteLeft,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    controller.reviewModel!.details,
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  controller.reviewModel!.status == 0
                                      ? "PENDING"
                                      : "APPROVED",
                                  style: TextStyle(color: AppColors.amber),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(
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
                                  const Text("Display Name"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomEditText().boxEditText(
                                      controller.nameController,
                                      '',
                                      'Name',
                                      Helper.validationAverage,
                                      TextInputType.name,
                                      boxTextFieldColor),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text("Review Title"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomEditText().boxEditText(
                                      controller.titleController,
                                      '',
                                      'Title',
                                      Helper.validationAverage,
                                      TextInputType.name,
                                      boxTextFieldColor),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text("Write Review"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomEditText().boxEditText(
                                      controller.reviewController,
                                      '',
                                      'Write Review',
                                      Helper.validationReview,
                                      TextInputType.name,
                                      boxTextFieldColor,
                                      inputAction: TextInputAction.done,
                                      maxLines: 5),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    height: 48,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.mainColor,
                                          foregroundColor: Colors.white),
                                      onPressed: () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.formKey.currentState
                                              ?.save();
                                          if (controller.reviewModel == null) {
                                            Utils.closeKeyBoard(context);
                                            controller.postAReview();
                                          } else {
                                            Utils.closeKeyBoard(context);
                                            controller.updateAReview();
                                          }
                                        }
                                      },
                                      child: Text(controller.reviewModel == null
                                          ? "Save"
                                          : "Update"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SliverLayoutBuilder(builder: (p0, p1) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(),
                    );
                  }),
                ],
              ),
      ),
    );
  }
}
