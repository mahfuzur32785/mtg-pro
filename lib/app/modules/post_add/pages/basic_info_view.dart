import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/post_add/post_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../animation/delayed_animation.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/custom_edittext.dart';

class BasicInfoView extends StatelessWidget {
  const BasicInfoView({Key? key}) : super(key: key);

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
                    DelayedAnimation(
                      delay: controller.delayedAmount + 120,
                      child: HelperText().redNormalText("Purpose"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 150,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          ...List.generate(controller.purposeList.length, (index) {
                            return Material(
                              color: index == controller.purpose ? AppColors.mainColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: (){
                                  controller.changePurpose(index);
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: index == controller.purpose ? AppColors.mainColor : AppColors.ashTextColor,)
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(controller.purposeList[index],style: TextStyle(color: index == controller.purpose ? Colors.white : AppColors.ashTextColor,fontSize: 15),),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 180,
                      child: HelperText().redNormalText("Property type"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 200,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          ...List.generate(controller.propertyTypeList.length, (index) {
                            return Material(
                              color: index == controller.propertyType ? AppColors.mainColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: (){
                                  controller.changePropertyType(index);
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: index == controller.propertyType ? AppColors.mainColor : AppColors.ashTextColor,)
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(controller.propertyTypeList[index],style: TextStyle(color: index == controller.propertyType ? Colors.white : AppColors.ashTextColor,fontSize: 15),),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 230,
                      child: HelperText().redNormalText("City"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 250,
                      child: SizedBox(
                        child: DropdownButtonFormField<String>(
                          icon: const SizedBox(),
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainColor,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.ashTextColor,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            suffix: Icon(Icons.keyboard_arrow_down_outlined),
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          ),
                          value: controller.city,
                          items: controller.cityList.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e,style: const TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w400),),
                          )).toList(),
                          onChanged: (value) {
                            controller.changeCity(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 280,
                      child: HelperText().redNormalText("Area"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 300,
                      child: SizedBox(
                        child: DropdownButtonFormField<String>(
                          icon: const SizedBox(),
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainColor,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.ashTextColor,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            suffix: Icon(Icons.keyboard_arrow_down_outlined),
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),

                          ),
                          value: controller.city,
                          items: controller.cityList.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e,style: const TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w400),),
                          )).toList(),
                          onChanged: (value) {
                            controller.changeCity(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 300,
                      child: HelperText().redNormalText("Sub Area"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 350,
                      child: SizedBox(
                        child: DropdownButtonFormField<String>(
                          icon: const SizedBox(),
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.mainColor,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.ashTextColor,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              suffix: Icon(Icons.keyboard_arrow_down_outlined),
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              focusColor: AppColors.mainColor
                          ),
                          value: controller.city,
                          items: controller.cityList.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e,style: const TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w400),),
                          )).toList(),
                          onChanged: (value) {
                            controller.changeCity(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 380,
                      child: HelperText().redNormalText("Full Address"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 400,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomEditText().normalEditText(controller.houseNoController, controller.houseNo, "House no", Helper.validationAverage, TextInputType.number),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            flex: 1,
                            child: CustomEditText().normalEditText(controller.roadNoController, controller.roadNo, "Road no", Helper.validationAverage, TextInputType.text),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 450,
                      child: CustomEditText().normalEditText(controller.fullAddressController, controller.fullAddress, "Full Address", Helper.validationAverage, TextInputType.text),
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
