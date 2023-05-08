import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/settings_pages/pricing/controller/pricing_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../data/enums/state_status.dart';
import '../../../global_widgets/page_loader.dart';

class PricingScreen extends GetView<PricingController> {
  const PricingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().simpleAppBar("Pricing"),
      body: Obx(
        () => controller.stateStatus == StateStatus.LOADING
            ? const PageLoader()
            : controller.stateStatus == StateStatus.FAILURE
                ? Center(
                    child: Text(controller.errorText.value),
                  )
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Choose Your Best Plan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 0),
                        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              offset: const Offset(-5,-5),
                              color: Colors.grey.withOpacity(0.1)
                            ),
                            BoxShadow(
                              blurRadius: 6,
                              offset: const Offset(5,5),
                              color: Colors.grey.withOpacity(0.1)
                            ),
                          ]
                        ),
                        child: Row(
                          children: [
                            tabBox("Annual",controller.isAnnual.value == 1,(){
                              controller.changePlan(1);
                            }),
                            tabBox("Monthly",controller.isAnnual.value == 0,(){
                              controller.changePlan(0);
                            }),
                          ],
                        )
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: CarouselSlider(
                                  options: CarouselOptions(
                                    height: double.infinity,
                                    viewportFraction: 0.8,
                                    initialPage: controller.initialPage.value,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: const Duration(seconds: 5),
                                    autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    onPageChanged: controller.callBackFunction,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: [
                                    ...List.generate(controller.plans.length, (index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(vertical: 16),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 6,
                                                  offset: const Offset(-5,-5),
                                                  color: Colors.grey.withOpacity(0.1)
                                              ),
                                              BoxShadow(
                                                  blurRadius: 6,
                                                  offset: const Offset(5,5),
                                                  color: Colors.grey.withOpacity(0.1)
                                              ),
                                            ]
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              width: double.infinity,
                                              height: 16,
                                            ),
                                            Text(controller.plans[index].planName,style: const TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w600),),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            const Spacer(),
                                            RichText(
                                              text: TextSpan(
                                                  text: "\$${controller.getPrice(index)}",
                                                  style: TextStyle(color: AppColors.mainColor,fontSize: 30,fontWeight: FontWeight.w600),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.isAnnual.value == 1 ? " /Yearly": " /Monthly",
                                                      style: const TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w400),
                                                    )
                                                  ]
                                              ),
                                            ),

                                            const Spacer(),

                                            const Divider(
                                              height: 30,
                                            ),
                                            ...List.generate(controller.plans[index].features.length, (featureIndex) =>
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 16,
                                                        backgroundColor: AppColors.mainColor,
                                                        child: const Center(
                                                          child: Icon(Icons.check,color: Colors.white,size: 20,),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(child: Text(controller.plans[index].features[featureIndex],style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400),)),
                                                    ],
                                                  ),
                                                ),),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                              child: SizedBox(
                                                height: 48,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,
                                                    elevation: 10,
                                                    foregroundColor: Colors.white,
                                                    shadowColor: Colors.grey.withOpacity(0.2),
                                                  ),
                                                  onPressed: () async {
                                                    Get.toNamed(Routes.planDetails,arguments: {"plan": controller.plans[index],"isYearly": controller.isAnnual.value});
                                                    // Navigator.pushNamed(context, RouteNames.planDetailsScreen,arguments: state.pricingList[index]);
                                                  },
                                                  child: const Text("Choose Plan"),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    })
                                  ]
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...List.generate(4, (index) {
                                      return Container(
                                        height: index == controller.currentPage.value ? 12 : 8,
                                        width: index == controller.currentPage.value ? 12 : 8,
                                        margin: const EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                            color: index == controller.currentPage.value ? Colors.grey : Colors.black54,
                                            shape: BoxShape.circle
                                        ),
                                      );
                                    })
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
      ),
    );
  }

  Widget tabBox(String text,bool isSelected,Function onPressed){
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: isSelected ? AppColors.mainColor : Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: (){
            onPressed();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text(text,style: TextStyle(color: !isSelected ? AppColors.mainColor : Colors.white,),)),
          ),
        ),
      ),
    );
  }
}
