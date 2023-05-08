import 'package:mtgpro/app/modules/post_add/post_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../../global_widgets/helper_text.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({Key? key}) : super(key: key);

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
                    Wrap(
                      spacing: 20,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().redNormalText("Number of floor*"),
                              const SizedBox(
                                height: 0,
                              ),
                              SizedBox(
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
                                      suffix: const Icon(Icons.keyboard_arrow_down_outlined),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().redNormalText("Floor Available*"),
                              const SizedBox(
                                height: 0,
                              ),
                              SizedBox(
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
                                      suffix: const Icon(Icons.keyboard_arrow_down_outlined),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().redNormalText("Facing*"),
                              const SizedBox(
                                height: 0,
                              ),
                              SizedBox(
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
                                      suffix: const Icon(Icons.keyboard_arrow_down_outlined),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().redNormalText("Handover Date*"),
                              const SizedBox(
                                height: 0,
                              ),
                              SizedBox(
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
                                      suffix: const Icon(Icons.keyboard_arrow_down_outlined),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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
                            ],
                          ),
                        ),
                        //........... Headline..............
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().redNormalText("Ad Headline"),
                              const SizedBox(
                                height: 0,
                              ),
                              SizedBox(
                                child: CustomEditText().normalEditText(controller.totalPriceController,
                                    controller.totalPrice, "Ad Headline", Helper.validationAverage, TextInputType.text),
                              ),
                            ],
                          ),
                        ),
                        //........... Description ..............
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().redNormalText("Description"),
                              const SizedBox(
                                height: 0,
                              ),
                              SizedBox(
                                child: CustomEditText().normalEditText(controller.totalPriceController,
                                    controller.totalPrice, "Description 1", Helper.validationAverage, TextInputType.text),
                              ),
                              SizedBox(
                                child: CustomEditText().normalEditText(controller.totalPriceController,
                                    controller.totalPrice, "Description 2", Helper.validationAverage, TextInputType.text),
                              ),
                              SizedBox(
                                child: CustomEditText().normalEditText(controller.totalPriceController,
                                    controller.totalPrice, "Description 3", Helper.validationAverage, TextInputType.text),
                              ),
                            ],
                          ),
                        ),
                        //........... Select feature and facilities..............
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HelperText().redNormalText("Features*"),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeFixedPrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isFixedPrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().boldText("Select All")
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeHidePrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isHidePrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().normalText("Electricity")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeFixedPrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isFixedPrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().normalText("Tital Gas")
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeHidePrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isHidePrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().normalText("Lift")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16,),
                              HelperText().redNormalText("Facilities with 1km*"),
                              const SizedBox(
                                height: 6,
                              ),
                              const SizedBox(
                                height: 0,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeFixedPrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isFixedPrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().boldText("Select All")
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeHidePrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isHidePrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().normalText("Bazar")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeFixedPrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isFixedPrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().normalText("Mosjid")
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.changeHidePrice();
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          LayoutBuilder(
                                            builder: (context,constraints){
                                              if (controller.isHidePrice.value) {
                                                return Icon(Icons.check_box_outlined,color: AppColors.textColor,size: 24,);
                                              } else {
                                                return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.textColor,);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 10,),
                                          HelperText().normalText("School")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
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
