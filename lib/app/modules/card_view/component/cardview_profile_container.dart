import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/modules/card_view/controller/card_view_controller.dart';
import 'package:mtgpro/app/modules/card_view/model/card_preview_model.dart';

import '../../../core/utils/constants.dart';

class CardViewProfileContainer extends StatelessWidget {
  const CardViewProfileContainer({Key? key, required this.cardPreviewModel})
      : super(key: key);
  final CardPreviewModel cardPreviewModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardViewController>(builder: (controller) {
      return Container(
        width: double.infinity,
        height: screenWidth(context) * 0.65,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: screenWidth(context),
                height: screenWidth(context) * 0.45,
                decoration: const BoxDecoration(color: Colors.white),
                child: CustomImage(
                  path: cardPreviewModel.coverPicUrl,
                  fit: BoxFit.cover,
                ),
                // child: LayoutBuilder(
                //     builder: (context,constraints) {
                //       return Image.asset("assets/images/background.jpg",fit: BoxFit.cover);
                //     }
                // )
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth(context) * 0.4,
                height: screenWidth(context) * 0.4,
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
                      width: screenWidth(context) * 0.4,
                      height: screenWidth(context) * 0.4,
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
                        child: CustomImage(
                          path: cardPreviewModel.profilePicUrl,
                          fit: BoxFit.cover,
                        ),
                        // child: LayoutBuilder(
                        //     builder: (context,constraints) {
                        //       return Image.asset("assets/images/arif.jpg",fit: BoxFit.cover);
                        //     }
                        // )
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: screenWidth(context) * 0.1,
                        height: screenWidth(context) * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: 2,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CustomImage(
                            path: cardPreviewModel.logoPicUrl,
                            fit: BoxFit.cover,
                          ),
                          // child: LayoutBuilder(
                          //     builder: (context,constraints) {
                          //       return Image.asset("assets/images/arobil_logo.png",fit: BoxFit.cover);
                          //     }
                          // )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            )
          ],
        ),
      );
    });
  }
}
