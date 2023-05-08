import 'package:mtgpro/app/modules/post_add/post_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../animation/delayed_animation.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/values/colors.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../../global_widgets/helper_text.dart';

class PricingView extends StatelessWidget {
  const PricingView({Key? key}) : super(key: key);

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
                      child: HelperText().redNormalText("Condition"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 150,
                      child: HelperText().redNormalText("City"),
                    ),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 180,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          ...List.generate(controller.conditionList.length, (index) {
                            return Material(
                              color: index == controller.condition ? AppColors.mainColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: (){
                                  controller.changeCondition(index);
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: index == controller.condition ? AppColors.mainColor : AppColors.ashTextColor,)
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(controller.conditionList[index],style: TextStyle(color: index == controller.condition ? Colors.white : AppColors.ashTextColor,fontSize: 15),),
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
                      delay: controller.delayedAmount + 200,
                      child: HelperText().redNormalText("Size"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ///............... another design of size ,,,,,,,,,,,,,,,,,,,,
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Expanded(
                    //       flex: 1,
                    //       child: Container(
                    //         child: InputDecorator(
                    //           decoration: InputDecoration(
                    //             labelText: 'XP',
                    //             floatingLabelAlignment: FloatingLabelAlignment.center,
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //           ),
                    //           child: const Text('content goes here'),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
                    ...List.generate(controller.sizes.length, (index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DelayedAnimation(
                            delay: controller.delayedAmount + 200,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    // height: 60,
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                                            // height: double.infinity,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(color: AppColors.ashTextColor,width: 1),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Wrap(
                                              spacing: 16,
                                              runSpacing: 16,
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: TextFormField(
                                                    // validator: validator,
                                                    // controller: controller,
                                                    textInputAction: TextInputAction.next,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                    maxLines: 1,
                                                    onSaved: (String? val) {
                                                      // text = val;
                                                    },
                                                    onChanged: (val){
                                                      if (val != "") {
                                                        controller.sizes[index].sft = int.parse(val.toString());
                                                      } else {
                                                        controller.sizes[index].sft = 0;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      // filled: true,
                                                      // fillColor: Colors.white,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                                      hintText: "size in sft",
                                                      hintStyle: TextStyle(color: AppColors.ashTextColor,fontWeight: FontWeight.w400,fontSize: 12),
                                                      // labelText: 'Email',
                                                      // isDense: true,
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(color: AppColors.textColor),
                                                      ),
                                                      errorBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
                                                      ),
                                                      border: UnderlineInputBorder(
                                                        borderSide: BorderSide(color: AppColors.ashTextColor),
                                                      ),
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(color: AppColors.ashTextColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 60,
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
                                                      // suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                                                      suffix: const Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                                    ),
                                                    value: controller.sizes[index].bed,
                                                    items: controller.sizes[index].beds?.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e,style: const TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),),
                                                    )).toList(),
                                                    onChanged: (value) {
                                                      // controller.changeCity(value);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 60,
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
                                                      // suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                                                      suffix: const Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                                    ),
                                                    value: controller.sizes[index].bath,
                                                    items: controller.sizes[index].baths?.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e,style: const TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),),
                                                    )).toList(),
                                                    onChanged: (value) {
                                                      // controller.changeCity(value);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
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
                                                      // suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                                                      suffix: const Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                                    ),
                                                    value: controller.sizes[index].balcony,
                                                    items: controller.sizes[index].balconies?.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e,style: const TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),),
                                                    )).toList(),
                                                    onChanged: (value) {
                                                      // controller.changeCity(value);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Positioned(
                                          top: -10,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFF4F4F4),
                                                border: Border.all(color: AppColors.ashTextColor,width: 1),
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Text("Size ${index+1}",style: const TextStyle(color: Colors.black87,fontSize: 10),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Material(
                                  color: index == controller.sizes.length -1 ? AppColors.mainColor : AppColors.ashTextColor,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    onTap: (){
                                      if (index == (controller.sizes.length-1)) {
                                        controller.addSize();
                                      } else {
                                        controller.removeSize(index);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(50),
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: index == controller.sizes.length -1
                                          ? const Icon(Icons.add,size: 20,color: Colors.white,)
                                          : const Icon(Icons.close,size: 20,color: Colors.white,),
                                    ),
                                  ),
                                )
                                // FloatingActionButton.small(
                                //   shape: const CircleBorder(),
                                //   backgroundColor: AppColors.mainColor,
                                //   onPressed: (){
                                //
                                //   },
                                //   child: const Icon(Icons.add),
                                // )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,)
                        ],
                      );
                    }),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 230,
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HelperText().redNormalText("Car Parking*"),
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
                                HelperText().redNormalText("Land Area*"),
                                const SizedBox(
                                  height: 0,
                                ),
                                SizedBox(
                                  child: CustomEditText().normalEditText(controller.landAreaController,
                                      controller.landArea, "Land Area", Helper.validationAverage, TextInputType.number),
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
                                HelperText().redNormalText("Price per sft*"),
                                const SizedBox(
                                  height: 0,
                                ),
                                SizedBox(
                                  child: CustomEditText().normalEditText(controller.pricePerStfController,
                                      controller.pricePerStf, "Price per sft", Helper.validationAverage, TextInputType.number),
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
                                HelperText().redNormalText("Others cost*"),
                                const SizedBox(
                                  height: 0,
                                ),
                                SizedBox(
                                  child: CustomEditText().normalEditText(controller.othersCostController,
                                      controller.othersCost, "Others cost", Helper.validationAverage, TextInputType.number),
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
                                HelperText().redNormalText("Total Price"),
                                const SizedBox(
                                  height: 0,
                                ),
                                SizedBox(
                                  child: CustomEditText().normalEditText(controller.totalPriceController,
                                      controller.totalPrice, "Total Price", Helper.validationAverage, TextInputType.number),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    DelayedAnimation(
                      delay: controller.delayedAmount + 250,
                      child: Row(
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
                                        return Icon(Icons.check_box_outlined,color: AppColors.mainColor,size: 24,);
                                      } else {
                                        return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.mainColor,);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 10,),
                                  HelperText().redNormalText("Fixed Price")
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
                                        return Icon(Icons.check_box_outlined,color: AppColors.mainColor,size: 24,);
                                      } else {
                                        return Icon(Icons.check_box_outline_blank_outlined,color: AppColors.mainColor,);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 10,),
                                  HelperText().redNormalText("Hide Price")
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
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
