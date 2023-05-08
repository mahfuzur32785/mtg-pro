
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/post_add/pages/basic_info_view.dart';
import 'package:mtgpro/app/modules/post_add/pages/description_view.dart';
import 'package:mtgpro/app/modules/post_add/pages/contacts_view.dart';
import 'package:mtgpro/app/modules/post_add/pages/package_plan_view.dart';
import 'package:mtgpro/app/modules/post_add/pages/picture_view.dart';
import 'package:mtgpro/app/modules/post_add/pages/pricing_view.dart';
import 'package:mtgpro/app/modules/post_add/post_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PostAdScreen extends StatelessWidget {
  const PostAdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostAdController>(
      init: PostAdController(),
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            appBar: CustomAppBar().colorAppBar("Post Ad",AppColors.mainColor,false),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Icon(Icons.circle,color: controller.pageIndex > -1 ? AppColors.mainColor : AppColors.ashTextColor,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 2,
                                      width: 40,
                                      color: controller.pageIndex > 0 ? AppColors.mainColor : AppColors.ashTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text("Basic Info",textAlign: TextAlign.left,
                                style: TextStyle(color: controller.pageIndex > -1 ? AppColors.mainColor : AppColors.ashTextColor,fontSize: 10),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Icon(Icons.circle,color: controller.pageIndex > 0 ? AppColors.mainColor : AppColors.ashTextColor,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 2,
                                      width: 40,
                                      color: controller.pageIndex > 1 ? AppColors.mainColor : AppColors.ashTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text("Size,Price",textAlign: TextAlign.left,
                                style: TextStyle(color: controller.pageIndex > 0 ? AppColors.mainColor : AppColors.ashTextColor,fontSize: 10),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Icon(Icons.circle,color: controller.pageIndex > 1 ? AppColors.mainColor : AppColors.ashTextColor,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 2,
                                      width: 40,
                                      color: controller.pageIndex > 2 ? AppColors.mainColor : AppColors.ashTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text("Description",textAlign: TextAlign.left,
                                style: TextStyle(color: controller.pageIndex > 1 ? AppColors.mainColor : AppColors.ashTextColor,fontSize: 10),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Icon(Icons.circle,color: controller.pageIndex > 2 ? AppColors.mainColor : AppColors.ashTextColor,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 2,
                                      width: 40,
                                      color: controller.pageIndex > 3 ? AppColors.mainColor : AppColors.ashTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text("Images",textAlign: TextAlign.left,
                                style: TextStyle(color: controller.pageIndex > 2 ? AppColors.mainColor : AppColors.ashTextColor,fontSize: 10),),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 0,
                                ),
                                Icon(Icons.circle,color: controller.pageIndex > 3 ? AppColors.mainColor : AppColors.ashTextColor,),
                              ],
                            ),
                            Text("Contacts",textAlign: TextAlign.left,
                              style: TextStyle(color: controller.pageIndex > 3 ? AppColors.mainColor : AppColors.ashTextColor,fontSize: 10),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (int value){
                        controller.changePage(value);
                      },
                      children: const [
                        BasicInfoView(),
                        PricingView(),
                        DescriptionView(),
                        PictureView(),
                        ContactsView(),
                        PackagePlanView(),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints){
                            if(controller.pageIndex > 0){
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                height: 50,
                                width: 100,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(side: BorderSide(color: AppColors.mainColor,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                  onPressed: (){
                                    controller.pageController.previousPage(duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Text("Previous",style: TextStyle(color: AppColors.mainColor),),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                            onPressed: () async {

                              controller.pageController.nextPage(duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);

                              // if(controller.pageIndex == 0){
                              //   if(controller.firstPageKey.currentState!.validate()){
                              //     controller.firstPageKey.currentState!.save();
                              //     if(controller.medicineImage != null){
                              //       controller.pageController.nextPage(duration: const Duration(milliseconds: 300),
                              //           curve: Curves.easeInOut);
                              //     } else {
                              //       Get.snackbar("Image", "Select An Image!");
                              //     }
                              //   }
                              // } else if(controller.pageIndex == 1){
                              //   if(controller.typeOfMedicine != -1
                              //       && controller.isStomach != -1
                              //       && controller.timeOfTakeMedicine.isNotEmpty){
                              //     controller.pageController.nextPage(duration: const Duration(milliseconds: 300),
                              //         curve: Curves.easeInOut);
                              //   } else {
                              //     Get.snackbar("Warning", "Select All Info!");
                              //   }
                              // } else if(controller.pageIndex == 2){
                              //   if(controller.powerKey.currentState!.validate()){
                              //     controller.powerKey.currentState!.save();
                              //     controller.pageController.nextPage(duration: const Duration(milliseconds: 300),
                              //         curve: Curves.easeInOut);
                              //   }
                              // } else if(controller.pageIndex == 3){
                              //   try {
                              //     final result = await InternetAddress.lookup('example.com');
                              //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                              //       // connected
                              //       controller.saveMedicine();
                              //     }else{
                              //       Get.snackbar("Message", "No Internet Connection");
                              //     }
                              //   } on SocketException catch (_) {
                              //     Get.snackbar("Message", "No Internet Connection");
                              //   }
                              // }
                            },
                            child: Text(controller.pageIndex == 3 ? "Save" : "Next",style: const TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
