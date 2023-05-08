import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/utils/my_sharedpreferences.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/global_widgets/page_refresh.dart';
import 'package:mtgpro/app/modules/home_cards/component/mtg_card.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';
import 'package:mtgpro/app/modules/scanner/component/scanner_icon.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../core/utils/utils.dart';
import '../../data/remote_urls.dart';

class HomeCardsScreen extends GetView<HomeCardsController> {
  const HomeCardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageRefresh(
      onTap: () => controller.getCards(isLoad: false),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            title: ElevatedButton(
              onPressed: (){
                Get.toNamed(Routes.cardView,
                    arguments: controller.userInfo?.username);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
                  )
              ),
              child: const Text("Live Card"),
            ),
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white),
            elevation: 0,
            titleSpacing: 16,
            pinned: true,
            leading: const ScannerIconButton(),
            actions: [
              IconButton(
                onPressed: () {
                  var body = 'Hi there! Please click this link to check out my professional business card ${RemoteUrls.rootUrl}${controller.userInfo?.username}';
                  Utils.appLaunchEmail(body);
                },
                tooltip: "Share you card by mail",
                icon: FaIcon(FontAwesomeIcons.solidEnvelope, color: AppColors.mainColor),
              ),
              IconButton(
                onPressed: () {
                  var body = 'Hi there! Please click this link to check out my professional business card ${RemoteUrls.rootUrl}${controller.userInfo?.username}';
                  Utils.appLaunchTextSMS(body);
                },
                tooltip: "Share you card by text message",
                icon: FaIcon(FontAwesomeIcons.solidMessage, color: AppColors.mainColor),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 1,
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() => controller.isLoading.value
                ? SizedBox(
              height: MediaQuery.of(context).size.height - 150,
                child: const PageLoader())
                : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.75),
                    itemBuilder: (context, index) {
                      return MtgCardLayout(index: index,cardModel: controller.cardList[index],);
                    },
              itemCount: controller.cardList.length,
                  )),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75),
              delegate: SliverChildBuilderDelegate((context, index) {
                return MtgCardLayout(index: index, cardModel: controller.cardList[index],);
              }, childCount: 0),
            ),
          )
        ],
      ),
    );
  }
}
