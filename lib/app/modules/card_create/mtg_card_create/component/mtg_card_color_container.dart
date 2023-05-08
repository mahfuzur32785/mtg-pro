import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';

import '../controller/mtg_card_create_controller.dart';

class MtgCardColorContainer extends GetView<MtgCreateCardController> {
  const MtgCardColorContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: HelperText().boldText("Choose a card color"),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(controller.colorList.length, (index){
                return Obx((){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: controller.selectedColor.value == index ? Colors.grey.withOpacity(1) : Colors.transparent,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Material(
                          shape: const CircleBorder(),
                          color: controller.colorList[index],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: (){
                              print('#${controller.colorList[controller.selectedColor.value].value.toRadixString(16).substring(2)}');
                              controller.changeColor(index);
                            },
                            child: SizedBox(
                              height: 24,
                              width: controller.selectedColor.value == index ? 26 : 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              }),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: ashColor,),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Colored Social Icons"),
              Obx(() {
                return Switch(
                  value: controller.isColoredIcons.value,
                  activeColor: AppColors.mainColor,
                  onChanged: (value){
                    controller.changeIsColoredIcons(value);
                  },
                );
              }
              )
            ],
          ),
        )
      ],
    );
  }
}
