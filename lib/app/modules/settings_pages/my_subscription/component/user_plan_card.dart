import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtgpro/app/animation/custom_delayed_animation.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/data/enums/state_status.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/controller/subscription_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../../core/values/colors.dart';

class UserPlanCard extends GetView<SubscriptionController> {
  const UserPlanCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.planStateStatus == StateStatus.LOADING
        ? const PageLoader()
        : controller.planStateStatus == StateStatus.FAILURE
            ? Center(
                child: Text(controller.planErrorText.value),
              )
            : CustomDelayedAnimation(
                delay: 100,
                dx: 0,
                dy: -0.1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Current Plan",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${controller.currentPlan?.planName}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      controller.currentPlan?.isFree == 1
                                          ? '\$0.00/${controller.currentPlan?.packageType}'
                                          : '\$${controller.getPrice()}',
                                      style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )),
                                const Text("Status"),
                                Row(
                                  children: [
                                    Icon(
                                      controller.currentPlan?.status == 1 ? Icons.check_box : Icons.check_box_outline_blank,
                                      color: controller.currentPlan?.status == 1 ? Colors.green : Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      controller.currentPlan?.status == 1 ? "Active" : "Inactive",
                                      style: GoogleFonts.kanit(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(left: 16),
                                  child: ElevatedButton(
                                    style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.white,
                                        backgroundColor: AppColors.mainColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6))),
                                    onPressed: () {
                                      Get.toNamed(Routes.pricingPlan);
                                    },
                                    child: const Text("Upgrade Plan"),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(left: 16),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.mainColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6))),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Alert"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Center(
                                                child: Text(
                                                    "Are you sure you want to cancel the plan? "),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                controller.cancelPlan();
                                              },
                                              child: const Text("Ok"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Text("Cancel Subscription"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${controller.currentPlan?.remainingDays} days left",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // RichText(
                      //   text: const TextSpan(
                      //       text: "Member since ",
                      //       style: TextStyle(color: Colors.black54),
                      //       children: <TextSpan>[
                      //         TextSpan(
                      //           text: "January 29,2023",
                      //           style: TextStyle(color: Colors.black87),
                      //         ),
                      //       ]),
                      // ),
                      // const SizedBox(
                      //   height: 6,
                      // ),
                      // RichText(
                      //   text: const TextSpan(
                      //       text: "Renew Subscription by ",
                      //       style: TextStyle(color: Colors.black54),
                      //       children: <TextSpan>[
                      //         TextSpan(
                      //           text: "January 29,2024",
                      //           style: TextStyle(color: Colors.black87),
                      //         ),
                      //       ]),
                      // ),
                    ],
                  ),
                ),
              ));
  }
}
