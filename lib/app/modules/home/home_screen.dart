import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/core/values/strings.dart';
import 'package:mtgpro/app/modules/card_view/component/view_dialogs.dart';
import 'package:mtgpro/app/modules/home/home_controller.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:mtgpro/app/modules/scanner/controller/scanner_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../data/remote_urls.dart';
import '../../global_widgets/drawer_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () => controller.onBackPressed(context),
          child: Scaffold(
            key: scaffoldKey,
            // appBar: AppBar(
            //   titleSpacing: 16,
            //   backgroundColor: AppColors.mainColor,
            //   iconTheme: const IconThemeData(color: Colors.white),
            //   title: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       const CircleAvatar(
            //         radius: 22,
            //         backgroundImage: AssetImage("assets/images/arif.jpg"),
            //       ),
            //       const SizedBox(
            //         width: 8,
            //       ),
            //       Column(
            //         mainAxisSize: MainAxisSize.min,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: const [
            //           Text("Arifur Rahman",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),),
            //           Text("Developer",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400,fontSize: 10),),
            //         ],
            //       )
            //     ],
            //   ),
            //   systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light,statusBarColor: AppColors.mainColor),
            //   // leading: IconButton(
            //   //   icon: const Icon(Icons.menu),
            //   //   onPressed: () {
            //   //     scaffoldKey.currentState!.openDrawer();
            //   //   },
            //   // ),
            //   actions: [
            //     Material(
            //       color: Colors.transparent,
            //       borderRadius: BorderRadius.circular(50),
            //       child: InkWell(
            //         borderRadius: BorderRadius.circular(50),
            //         onTap: (){
            //           Get.toNamed(Routes.reflectly);
            //         },
            //         child: SizedBox(
            //           height: 40,
            //           width: 40,
            //           child: Center(
            //             child: Badge(
            //               badgeColor: Colors.white,
            //               toAnimate: false,
            //               shape: BadgeShape.circle,
            //               position: BadgePosition.topEnd(),
            //               badgeContent: Text("9",style: TextStyle(color: AppColors.mainColor,fontSize: 8),),
            //               child: const Icon(Icons.notifications_none,size: 24,),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 16,
            //     ),
            //   ],
            // ),
            backgroundColor: Colors.white,
            body: PageView(
              controller: controller.pageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                // controller.changePage(index);
                // controller.pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
              },
              children: controller.screenList,
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: HomeDrawer(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              backgroundColor: AppColors.mainColor,
              fixedColor: Colors.white,
              unselectedItemColor: Colors.white60,
              elevation: 3,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: Colors.white60),
              selectedLabelStyle: GoogleFonts.biryani(),
              unselectedLabelStyle: GoogleFonts.biryani(),
              onTap: (index) {
                if (index == 0) {
                  controller.changePage(index);
                  controller.pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                } else if (index == 1) {
                  final HomeCardsController homeCardsController = Get.find();
                  List<CardModel> cards = homeCardsController.cardList.value as List<CardModel>;
                  CardModel cardModel = cards.singleWhere((element) => element.isLiveCard);
                  Utils.loadingDialog(context);
                  Utils.viewQrImage("${RemoteUrls.baseUrl}qr/${cardModel.cardId}", cardModel.cardId).then((value) {
                    if (kDebugMode) {
                      print(value.path);
                    }
                    Utils.closeDialog(context);
                    CardViewDialogs.shareFromHome(context,cardModel,value.path);
                  });
                } else if (index == 3) {
                  scaffoldKey.currentState!.openDrawer();
                } else {
                  controller.changePage(index);
                  controller.pageController.animateToPage(index - 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                }
              },
              currentIndex: controller.pageIndex,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: AppColors.mainColor,
                  icon: const FaIcon(FontAwesomeIcons.addressCard),
                  label: "Cards",
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColors.mainColor,
                  icon: const FaIcon(FontAwesomeIcons.qrcode),
                  label: "QR",
                  tooltip: "Click opens QR code to live profile",
                ),
                // BottomNavigationBarItem(
                //   backgroundColor: AppColors.mainColor,
                //   icon: const FaIcon(FontAwesomeIcons.starHalfStroke),
                //   label: "My Review",
                // ),
                BottomNavigationBarItem(
                  backgroundColor: AppColors.mainColor,
                  icon: const Icon(Icons.bar_chart),
                  label: "Insights",
                ),
                BottomNavigationBarItem(
                  backgroundColor: AppColors.mainColor,
                  icon: const Icon(Icons.menu),
                  label: "More",
                ),
                // BottomNavigationBarItem(
                //   backgroundColor: AppColors.mainColor,
                //   icon: const Icon(Icons.account_circle_rounded),
                //   label: "Settings",
                // ),
              ],
            ),
            extendBodyBehindAppBar: false,
            floatingActionButton: Visibility(
              visible: controller.pageIndex != 3,
              child: FloatingActionButton(
                tooltip: "Create New Card",
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
                onPressed: () {
                  // return;
                  Get.toNamed(Routes.mtgCreateCard);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);
  final HomeCardsController homeCardsController = Get.find();
  final ScannerController scannerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              // color: const Color(0xFFF4F4F4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage("${homeCardsController.userInfo?.profileImage}"),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: Text(
                    "${homeCardsController.userInfo?.name}",
                    style: const TextStyle(color: Colors.black54),
                  )),
                  const SizedBox(
                    height: 4,
                  ),
                  Center(
                      child: Text(
                        "${homeCardsController.userInfo?.email}",
                    style: const TextStyle(color: Colors.black54),
                  )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DrawerButton(
              icon: Icons.dashboard_rounded,
              text: "PRO device activation",
              onPressed: () async {
                bool isAvailable = await NfcManager.instance.isAvailable();
                if (isAvailable) {
                  scannerController.scanQrCode().then((value) {
                    if (value != null) {
                      if (value == scanKey) {
                        Get.toNamed(Routes.writeNfcCard,arguments: "${RemoteUrls.rootUrl}${homeCardsController.userInfo?.username}");
                      } else {
                        Helper.toastMsg("You scanned wrong QR Code");
                      }
                    }
                  });
                } else {
                  Get.snackbar(
                      "Warning", "Please Start your mobile device NFC");
                }
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 1,
            ),
          ),
          SliverToBoxAdapter(
            child: DrawerButton(
              icon: Icons.maps_home_work_outlined,
              text: "Settings",
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed(Routes.setting);
              },
            ),
          ),
        ],
      ),
    );
  }
}
