import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_vcard_controller.dart';

import '../../routes/routes.dart';
import 'component/bottom_nav.dart';

class CreateStepVcardEmail extends StatelessWidget {
  const CreateStepVcardEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateStepVcardController>(
      builder: (controller){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar().createStepVcardAppBar(4),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: StepVCardsBottomNav(text: "Next",onPressed: (){
            Get.toNamed(Routes.stepVCardsPassword);
          }),
        );
      },
    );
  }
}
