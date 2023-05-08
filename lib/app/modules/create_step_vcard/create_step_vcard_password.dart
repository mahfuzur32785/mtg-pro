import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_vcard_controller.dart';

import '../../routes/routes.dart';
import 'component/bottom_nav.dart';

class CreateStepVcardPassword extends StatelessWidget {
  const CreateStepVcardPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateStepVcardController>(
      builder: (controller){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar().createStepVcardAppBar(5),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: StepVCardsBottomNav(text: "Next",onPressed: (){
            Get.offAllNamed(Routes.home);
          }),
        );
      },
    );
  }
}
