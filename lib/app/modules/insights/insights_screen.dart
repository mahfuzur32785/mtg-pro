import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/data/dummy_data.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/global_widgets/page_refresh.dart';
import 'package:mtgpro/app/modules/home/home_controller.dart';
import 'package:mtgpro/app/modules/insights/controller/insights_controller.dart';
import 'package:mtgpro/app/modules/scanner/component/scanner_icon.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../core/values/colors.dart';

class InsightsScreen extends GetView<InsightsController> {
  const InsightsScreen({Key? key}) : super(key: key);

  // final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const PageLoader()
        : PageRefresh(
            onTap: () => controller.getInsights(isLoad: false),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    "Insights",
                    style: TextStyle(color: AppColors.mainColor),
                  ),
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white),
                  elevation: 3,
                  titleSpacing: 0,
                  pinned: true,
                  // leading: const ScannerIconButton(),
                  leading: IconButton(
                    onPressed: (){
                      final HomeController homeController = Get.put(HomeController());
                      homeController.changePage(0);
                      homeController.pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  actions: const [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.add, color: AppColors.mainColor),
                    // )
                  ],
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.5),
                    delegate: SliverChildListDelegate(
                      [
                        InsightsCard(title: "Total Connect", value: '${controller.insights!.totalConnect}',onTap: (){
                          Get.toNamed(Routes.crmScreen);
                        }),
                        InsightsCard(title: "Card View", value: '${controller.insights!.totalCardView}',onTap: (){
                          Get.toNamed(Routes.cardViewHistoryScreen);
                        }),
                        InsightsCard(title: "Contacts Download", value: '${controller.insights!.totalContactDownload}',onTap: (){
                          Get.toNamed(Routes.contactDownloadHistoryScreen);
                        }),
                        InsightsCard(title: "QR Code Downloaded", value: '${controller.insights!.totalQrcodeDownload}',onTap: (){
                          Get.toNamed(Routes.qrDownloadHistoryScreen);
                        }),
                        InsightsCard(title: "Total Cards", value: '${controller.insights!.totalCard}',onTap: (){
                          final HomeController homeController = Get.find();
                          homeController.changePage(0);
                          homeController.pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        }),
                        InsightsCard(title: "Current Plan",value: '${controller.insights?.currentPlan.planName}',onTap: (){

                        }),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ));
  }
}

class InsightsCard extends StatelessWidget {
  const InsightsCard({Key? key, required this.title, required this.value, required this.onTap}) : super(key: key);
  final String title;
  final String value;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(10, 10)),
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 3,
                  offset: const Offset(-2, -2)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}

