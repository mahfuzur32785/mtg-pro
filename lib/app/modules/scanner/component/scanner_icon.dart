import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/modules/scanner/controller/scanner_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../core/values/colors.dart';

class ScannerIconButton extends GetView<ScannerController> {
  const ScannerIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value ? const PageLoader() : IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: const Color(0xFFF4F4F4),
                elevation: 3,
                // isDismissible: true,
                isScrollControlled: false,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
                ),
                builder: (context){
                  return DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      maxChildSize: 0.3,
                      minChildSize: 0.3,
                      expand: false,
                      builder: (context, scrollController) {
                        return Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                      controller.scanTextRecognizer(1);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          FaIcon(FontAwesomeIcons.camera,size: 35,),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Text("Camera")
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                      controller.scanTextRecognizer(2);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          FaIcon(FontAwesomeIcons.image,size: 35,),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Text("Gallery")
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  );
                }
            );

            // controller.scanQrCode().then((value) {
            //   if (value != null) {
            //     String cardId = value.split("/").last;
            //     print('Card Id : $cardId .....................');
            //     Get.toNamed(Routes.cardView,arguments: cardId);
            //   } else {
            //     Helper.toastMsg("Card Not Found! try again");
            //   }
            // });
          },
          icon: Icon(Icons.document_scanner, color: AppColors.mainColor),
        )
    );
  }
}
