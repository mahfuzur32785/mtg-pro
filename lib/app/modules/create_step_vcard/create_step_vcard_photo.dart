import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/create_step_vcard/controller/create_step_vcard_controller.dart';

import '../../routes/routes.dart';
import 'component/bottom_nav.dart';

class CreateStepVcardPhoto extends GetView<CreateStepVcardController> {
  const CreateStepVcardPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateStepVcardController>(
      builder: (controller){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar().createStepVcardAppBar(2),
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Profile Photo",style: Theme.of(context).textTheme.headline6,),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white,width: 4,strokeAlign: BorderSide.strokeAlignOutside),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 0)
                                ),
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 0)
                                ),
                              ]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: LayoutBuilder(
                                builder: (context,constraints) {
                                  if (controller.image == null) {
                                    return Material(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(100),
                                        hoverColor: Colors.white70,
                                        onTap: (){
                                          controller.chooseImage();
                                        },
                                        child: Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              FaIcon(FontAwesomeIcons.image),
                                              Text("Choose Profile")
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Image(image: FileImage(
                                    File(controller.image!),
                                  ),fit: BoxFit.cover,);
                                  return Image.asset("assets/images/arif.jpg",fit: BoxFit.cover);
                                }
                              )

                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 50,
                            child: Visibility(
                              visible: controller.image != null,
                              child: Material(
                                color: AppColors.mainColor.withOpacity(0.6),
                                shape: const CircleBorder(),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: (){
                                    controller.editImage();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.edit,size: 24,color: Colors.white,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 50,
                            child: Visibility(
                              visible: controller.image != null,
                              child: Material(
                                color: AppColors.mainColor.withOpacity(0.6),
                                shape: const CircleBorder(),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: (){
                                    controller.deleteImage();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.delete,size: 24,color: Colors.white,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Photo tips:",style: Theme.of(context).textTheme.headlineSmall,),
                            Text("Size : 250 X 250 px",style: Theme.of(context).textTheme.bodyMedium,),
                            Text("Format : png / jpg / jpeg",style: Theme.of(context).textTheme.bodyMedium,),
                            // Text("High-quality headshots look the best!",style: Theme.of(context).textTheme.bodyText2,),
                            Text("You can choose different picture for each card!",style: Theme.of(context).textTheme.bodyMedium,),
                            Text("You can always change picture later.",style: Theme.of(context).textTheme.bodyMedium,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: StepVCardsBottomNav(text: "Create",onPressed: (){
            if (controller.image != null) {
              controller.stepCardCreate();
              // Utils.loadingDialog(context);
              // controller.btnLoader.value = true;
              // Future.delayed(const Duration(seconds: 3)).then((value) {
              //   controller.btnLoader.value = false;

                // Utils.closeDialog(context);
                // MySharedPreference.cacheIsCard();
                // Get.snackbar("Card Creation", "Successfully Created Your Card",);
                // Get.offAllNamed(Routes.home);
              // });
            } else {
              Helper.toastMsg("Choose image");
            }
          }),
        );
      },
    );
  }
}
