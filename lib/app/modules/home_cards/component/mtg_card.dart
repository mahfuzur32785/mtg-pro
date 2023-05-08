import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../core/utils/my_sharedpreferences.dart';
import '../../../core/values/colors.dart';
import 'card_option_container.dart';

class MtgCardLayout extends StatefulWidget {
  const MtgCardLayout({Key? key, required this.index, required this.cardModel}) : super(key: key);
  final int index;
  final CardModel cardModel;

  @override
  State<MtgCardLayout> createState() => _MtgCardLayoutState();
}

class _MtgCardLayoutState extends State<MtgCardLayout> {
  @override
  Widget build(BuildContext context) {
    final HomeCardsController homeCardController = Get.find();
    return Material(
      color: AppColors.white,
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () async {
          CardOptionContainer.cardOptions(context, widget.cardModel, widget.index,);
          // Navigator.pushNamed(context, Routes.cardView);
        },
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          color: ashColor
                      ),
                      child: Visibility(
                        visible: widget.cardModel.coverPicUrl != '',
                        child: CustomImage(
                          path: widget.cardModel.coverPicUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: Image(
                      //   image: AssetImage("assets/images/background.jpg"),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    Positioned(
                      bottom: -40,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: 4,
                                strokeAlign: BorderSide.strokeAlignOutside),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 0)),
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 0)),
                            ]),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                    strokeAlign: BorderSide.strokeAlignOutside),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return CustomImage(path: widget.cardModel.profilePicUrl == '' ? null : widget.cardModel.profilePicUrl);
                                    return Image.asset("assets/images/arif.jpg",
                                        fit: BoxFit.cover);
                                  })),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 16,
                                          offset: const Offset(0, 0)),
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 16,
                                          offset: const Offset(0, 0)),
                                    ]),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return CustomImage(path: widget.cardModel.logoPicUrl == '' ? null : widget.cardModel.logoPicUrl);
                                      return Image.asset(
                                          "assets/images/arobil_logo.png",
                                          fit: BoxFit.cover);
                                    })),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.cardModel.title,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.cardModel.designation,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 28,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(color: ashColor)),
                                onPressed: () {
                                  Get.toNamed(Routes.mtgCardEdit,arguments: widget.cardModel);
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 28,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(color: ashColor)),
                                onPressed: () async {
                                  int oldLiveId = homeCardController.liveCard.value;
                                  homeCardController.changeLiveCard(widget.cardModel.id);
                                  final result = await homeCardController.makeLiveCard(widget.cardModel.id);
                                  result.fold((l) {
                                    homeCardController.changeLiveCard(oldLiveId);
                                    Helper.toastMsg(l.message);
                                  }, (data) {
                                    Helper.toastMsg(data);
                                  });
                                },
                                child: Obx(() {
                                    return Row(
                                      children: [
                                        Visibility(
                                          visible: true,
                                          child: Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: widget.cardModel.id == homeCardController.liveCard.value ? Colors.green : ashTextColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Live",
                                          style: TextStyle(color: widget.cardModel.id == homeCardController.liveCard.value ? Colors.green : ashTextColor,fontSize: 12),
                                        ),
                                      ],
                                    );
                                  }
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
