import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/post_add/post_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../../global_widgets/helper_text.dart';

class PictureView extends StatelessWidget {
  const PictureView({Key? key}) : super(key: key);

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
                    HelperText().redHeadingText("Upload Images"),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (_, index) {
                        if (index == 0) {
                          return Material(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(3),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(3),
                              onTap: (){},
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  border: Border.all(color: AppColors.ashTextColor.withOpacity(0.4)),
                                ),
                                child: Center(
                                  child: Icon(Icons.add_circle_outlined,color: AppColors.mainColor,),
                                ),
                              ),
                            ),
                          );
                        }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.ashTextColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: Center(
                              child: Icon(Icons.image,color: AppColors.white,size: 50,),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.conditionList.length+1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HelperText().redHeadingText("Ad Youtube video link"),
                    SizedBox(
                      child: CustomEditText().normalEditText(controller.landAreaController,
                          controller.landArea, "Youtube Video link", Helper.validationAverage, TextInputType.number),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HelperText().redHeadingText("Ad Google map"),
                    SizedBox(
                      child: CustomEditText().normalEditText(controller.landAreaController,
                          controller.landArea, "Google map link", Helper.validationAverage, TextInputType.number),
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
