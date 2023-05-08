import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/helper_text.dart';
import '../post_ad_controller.dart';

class PackagePlanView extends StatelessWidget {
  const PackagePlanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostAdController>(
      builder: (controller){
        return CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelperText().headline("Get More Visibility"),
                    const SizedBox(
                      height: 8,
                    ),
                    HelperText().normalText("Get more responses from following advertisement options by selecting one or more options."),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.changeGeneralListing();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(controller.generalListing.value ? Icons.check_box_rounded : Icons.check_box_outline_blank_outlined,color: controller.generalListing.value ? AppColors.mainColor : AppColors.ashTextColor,size: 30,),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HelperText().redHeadingText("General Listing"),
                                    HelperText().ashSmallText("Ad will be for 30 days"),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: HelperText().redHeadingText("৳25"),
                              ),

                            ],
                          ),
                        ),
                        const Divider(
                          height: 24,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.changeFeaturedListing();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(controller.featuredListing.value ? Icons.check_box_rounded : Icons.check_box_outline_blank_outlined,color: controller.featuredListing.value ? AppColors.mainColor : AppColors.ashTextColor,size: 30,),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HelperText().redHeadingText("Featured Listing"),
                                    HelperText().ashSmallText("Ad will be for 30 days"),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: HelperText().redHeadingText("৳50"),
                              ),

                            ],
                          ),
                        ),
                        const Divider(
                          height: 24,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.changeAutoUpdateListing();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(controller.autoUpdateListing.value ? Icons.check_box_rounded : Icons.check_box_outline_blank_outlined,color: controller.autoUpdateListing.value ? AppColors.mainColor : AppColors.ashTextColor,size: 30,),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HelperText().redHeadingText("Listing Auto Update"),
                                    HelperText().ashSmallText("Ad will be for 30 days"),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: HelperText().redHeadingText("৳25"),
                              ),

                            ],
                          ),
                        ),
                        const Divider(
                          height: 24,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    HelperText().headline("Billing Summery"),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              LayoutBuilder(
                                builder: (context,constraints){
                                  if (controller.generalListing.value) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        HelperText().ashNormalText("General Listing"),
                                        const Spacer(),
                                        HelperText().ashNormalText("৳25"),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              LayoutBuilder(
                                builder: (context,constraints){
                                  if (controller.featuredListing.value) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        HelperText().ashNormalText("Featured Listing"),
                                        const Spacer(),
                                        HelperText().ashNormalText("৳50"),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              LayoutBuilder(
                                builder: (context,constraints){
                                  if (controller.autoUpdateListing.value) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        HelperText().ashNormalText("Listing Auto Update"),
                                        const Spacer(),
                                        HelperText().ashNormalText("৳25"),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              const Divider(),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  HelperText().boldText("Net payable amount "),
                                  const Spacer(),
                                  HelperText().boldText("৳50"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                        onPressed: (){
                          // Get.toNamed(Routes.postAdSuccess);
                          Get.toNamed(Routes.insufficientBalance);
                        },
                        child: const Text("Continue",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        );
      },
    );
  }
}
