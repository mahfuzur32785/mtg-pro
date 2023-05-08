import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_vcard_controller.dart';

import '../../../core/values/colors.dart';
import '../../../global_widgets/page_loader.dart';

class StepVCardsBottomNav extends GetView<CreateStepVcardController> {
  const StepVCardsBottomNav({Key? key, required this.onPressed, required this.text}) : super(key: key);
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0,5),
                blurRadius: 6
            ),
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(10,0),
                blurRadius: 6
            ),
          ]
      ),
      child: Obx(() => controller.btnLoader.value ? const PageLoader() :  ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        onPressed: (){
          onPressed();
        },
        child: Text(text,style: const TextStyle(color: Colors.white)),
      )
      ),
    );
  }
}
