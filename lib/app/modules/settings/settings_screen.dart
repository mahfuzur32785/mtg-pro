import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/services/notification_service.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/modules/settings/settings_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../scanner/component/scanner_icon.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    final HomeCardsController homeCardController  = Get.find();
    return Scaffold(
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller){
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverAppBar(
                  title: Text("Settings",style: TextStyle(color: AppColors.mainColor),),
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark,statusBarColor: Colors.white),
                  elevation: 0,
                  titleSpacing: 0,
                  pinned: true,
                  // leading: const ScannerIconButton(),
                  leading: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  actions: const [

                  ],
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    height: 1,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Utils.appLaunchUrl("https://www.mtgpro.me/");
                            return;
                            // Navigator.pushNamed(context, RouteNames.dashboardScreen);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.globe,size: 27,color: AppColors.mainColor,),
                          title: const Text("Website", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.myOrder);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.bagShopping,size: 27,color: AppColors.mainColor,),
                          title: const Text("My Order", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.crmScreen);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.user,size: 27,color: AppColors.mainColor,),
                          title: const Text("CRM", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.writeReview);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.star,size: 27,color: AppColors.mainColor,),
                          title: const Text("Write a Review", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.subscription);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.bell,size: 27,color: AppColors.mainColor,),
                          title: const Text("My Subscription", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.pricingPlan);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.dollarSign,size: 27,color: AppColors.mainColor,),
                          title: const Text("Pricing", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.freeMarketing);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.chartSimple,size: 27,color: AppColors.mainColor,),
                          title: const Text("Free Marketing Material", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.mortgageCalculator);
                            // Get.toNamed(Routes.calculator);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.calculator,size: 27,color: AppColors.mainColor,),
                          title: const Text("Mortgage Calculator", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.suggestFeature);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.message,size: 27,color: AppColors.mainColor,),
                              const Icon(Icons.question_mark,color: Colors.black87,size: 20,)
                            ],
                          ),
                          title: const Text("Suggest a Feature", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.accountSetting);
                            // Helper.toastMsg("Under Development");
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.userGear,size: 27,color: AppColors.mainColor,),
                          title: const Text("Account Settings", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Get.toNamed(Routes.support);
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.headphonesSimple,size: 27,color: AppColors.mainColor,),
                          title: const Text("Support", style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            Utils.loadingDialog(context);
                            Future.delayed(const Duration(seconds: 2)).then((value) async {
                              Utils.closeDialog(context);
                              await MySharedPreference.clearAll();
                              NotificationService.cachedNotify();
                              Get.offAllNamed(Routes.login);
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: FaIcon(FontAwesomeIcons.arrowRightFromBracket,size: 27,color: AppColors.mainColor,),
                          title: const Text("Logout", style: TextStyle(fontSize: 16)),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                minLeadingWidth: 0,
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage("${loginController.userInfo?.user.profileImage}"),
                                ),
                                title: Text("${loginController.userInfo?.user.name}", style: const TextStyle(fontSize: 16)),
                                subtitle: Text("${loginController.userInfo?.user.planDetails.planName}", style: const TextStyle(fontSize: 16)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                onPressed: (){
                                  Get.toNamed(Routes.pricingPlan);
                                },
                                child: const Text("Upgrade now"),
                              )
                            ],
                          ),
                        )
                      ]
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
