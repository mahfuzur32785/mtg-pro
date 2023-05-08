import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../core/values/strings.dart';
import '../../../data/remote_urls.dart';
import '../../scanner/controller/scanner_controller.dart';

class CardOptionContainer {
  static cardOptions(context,CardModel cardModel,index) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFF4F4F4),
        elevation: 3,
        // isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
        ),
        builder: (context){
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.6,
              expand: false,
              builder: (context, scrollController) {
                return CustomScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.primaries[index%10],
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
                        ),
                        child: Center(
                          child: Container(
                            height: 5,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Center(child: Text("Card Options")),
                    ),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      sliver: SliverGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: (){
                                final HomeCardsController homeCardController = Get.find();
                                if(cardModel.isLiveCard){
                                  Share.share(
                                      '${RemoteUrls.rootUrl}${homeCardController.userInfo?.username}',
                                      // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                      subject:
                                      'Click bellow the link to share Everisamting product');
                                } else {
                                  Share.share(
                                      '${RemoteUrls.rootUrl}${cardModel.cardUrl}',
                                      // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                      subject:
                                      'Click bellow the link to share Everisamting product');
                                }
                                },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(FontAwesomeIcons.paperPlane,size: 30,color: Colors.primaries[index%10]),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text("Send",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Share via QR, email, text and more.",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                                Get.toNamed(Routes.cardView,arguments: cardModel.cardUrl);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(FontAwesomeIcons.eye,size: 30,color: Colors.primaries[index%10]),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text("View",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Open your card in MTGPRO.ME",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                                Get.toNamed(Routes.mtgCardEdit,arguments: cardModel);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(FontAwesomeIcons.pencil,size: 30,color: Colors.primaries[index%10]),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text("Edit",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text("Customize your business card.",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            // visible: cardModel.isLiveCard,
                            visible: false,
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                // onTap: () async {
                                //   final HomeCardsController homeController = Get.find();
                                //   bool isAvailable = await NfcManager.instance.isAvailable();
                                //   if (isAvailable) {
                                //     Navigator.pop(context);
                                //     Get.toNamed(Routes.writeNfcCard,arguments: "${RemoteUrls.rootUrl}${homeController.userInfo?.username}");
                                //   } else {
                                //     Get.snackbar("Warning", "Please Start your mobile device NFC");
                                //   }
                                //   },
                                onTap: () async {
                                  final ScannerController scannerController = Get.find();
                                  final HomeCardsController homeController = Get.find();
                                  bool isAvailable = await NfcManager.instance.isAvailable();
                                  if (isAvailable) {
                                    scannerController.scanQrCode().then((value) {
                                      if (value != null) {
                                        if (value == scanKey) {
                                          Get.toNamed(Routes.writeNfcCard,arguments: "${RemoteUrls.rootUrl}${homeController.userInfo?.username}");
                                        } else {
                                          Helper.toastMsg("This is not valid card");
                                        }
                                      }
                                    });
                                  } else {
                                    Get.snackbar(
                                        "Warning", "Please Start your mobile device NFC");
                                  }
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(FontAwesomeIcons.nfcSymbol,size: 30,color: Colors.primaries[index%10]),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text("NFC",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text("Write to NFC.",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SliverPadding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                    //   sliver: SliverGrid.count(
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 10,
                    //     mainAxisSpacing: 10,
                    //     childAspectRatio: 3/1,
                    //     children: [
                    //       Material(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(16),
                    //         child: InkWell(
                    //           onTap: (){},
                    //           borderRadius: BorderRadius.circular(16),
                    //           child: Padding(
                    //             padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //             child: Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisSize: MainAxisSize.max,
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 FaIcon(FontAwesomeIcons.download,size: 20,color: Colors.primaries[index%10]),
                    //                 const SizedBox(
                    //                   width: 8,
                    //                 ),
                    //                 const Text("Download QR",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Material(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(16),
                    //         child: InkWell(
                    //           onTap: () async {
                    //             bool isAvailable = await NfcManager.instance.isAvailable();
                    //             if (isAvailable) {
                    //               Navigator.of(context).pop();
                    //               Get.toNamed(Routes.writeNfcCard,arguments: "https://www.mtgpro.me/63d632dc5e4c5");
                    //             } else {
                    //               Get.snackbar("Error", "Please Start your mobile device NFC");
                    //             }
                    //           },
                    //           borderRadius: BorderRadius.circular(16),
                    //           child: Padding(
                    //             padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //             child: Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisSize: MainAxisSize.max,
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 FaIcon(FontAwesomeIcons.nfcSymbol,size: 20,color: Colors.primaries[index%10]),
                    //                 const SizedBox(
                    //                   width: 8,
                    //                 ),
                    //                 const Text("Write to NFC",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       // Material(
                    //       //   color: Colors.white,
                    //       //   borderRadius: BorderRadius.circular(16),
                    //       //   child: InkWell(
                    //       //     onTap: (){},
                    //       //     borderRadius: BorderRadius.circular(16),
                    //       //     child: Padding(
                    //       //       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //       //       child: Row(
                    //       //         crossAxisAlignment: CrossAxisAlignment.center,
                    //       //         mainAxisSize: MainAxisSize.max,
                    //       //         mainAxisAlignment: MainAxisAlignment.start,
                    //       //         children: [
                    //       //           FaIcon(FontAwesomeIcons.paperPlane,size: 20,color: Colors.primaries[index%10]),
                    //       //           const SizedBox(
                    //       //             width: 8,
                    //       //           ),
                    //       //           const Text("Duplicate",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                    //       //         ],
                    //       //       ),
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //       // Material(
                    //       //   color: Colors.white,
                    //       //   borderRadius: BorderRadius.circular(16),
                    //       //   child: InkWell(
                    //       //     onTap: (){},
                    //       //     borderRadius: BorderRadius.circular(16),
                    //       //     child: Padding(
                    //       //       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //       //       child: Row(
                    //       //         crossAxisAlignment: CrossAxisAlignment.center,
                    //       //         mainAxisSize: MainAxisSize.max,
                    //       //         mainAxisAlignment: MainAxisAlignment.start,
                    //       //         children: [
                    //       //           FaIcon(FontAwesomeIcons.paperPlane,size: 20,color: Colors.primaries[index%10]),
                    //       //           const SizedBox(
                    //       //             width: 8,
                    //       //           ),
                    //       //           const Text("Transfer",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                    //       //         ],
                    //       //       ),
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //
                    //       Material(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(16),
                    //         child: InkWell(
                    //           onTap: (){},
                    //           borderRadius: BorderRadius.circular(16),
                    //           child: Padding(
                    //             padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //             child: Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisSize: MainAxisSize.max,
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 FaIcon(FontAwesomeIcons.gear,size: 20,color: Colors.primaries[index%10]),
                    //                 const SizedBox(
                    //                   width: 8,
                    //                 ),
                    //                 const Text("Settings",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       // Material(
                    //       //   color: Colors.white,
                    //       //   borderRadius: BorderRadius.circular(16),
                    //       //   child: InkWell(
                    //       //     onTap: (){},
                    //       //     borderRadius: BorderRadius.circular(16),
                    //       //     child: Padding(
                    //       //       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    //       //       child: Row(
                    //       //         crossAxisAlignment: CrossAxisAlignment.center,
                    //       //         mainAxisSize: MainAxisSize.max,
                    //       //         mainAxisAlignment: MainAxisAlignment.start,
                    //       //         children: [
                    //       //           FaIcon(FontAwesomeIcons.paperPlane,size: 20,color: Colors.primaries[index%10]),
                    //       //           const SizedBox(
                    //       //             width: 8,
                    //       //           ),
                    //       //           const Text("Delete",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                    //       //         ],
                    //       //       ),
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     height: 200,
                    //     color: Colors.pink,
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     height: 200,
                    //     color: Colors.pink,
                    //   ),
                    // ),
                  ],
                );
              }
          );
        }
    );
  }
}