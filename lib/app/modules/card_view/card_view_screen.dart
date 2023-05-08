import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/data/enums/social_icon_type.dart';
import 'package:mtgpro/app/data/enums/state_status.dart';
import 'package:mtgpro/app/data/remote_urls.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/modules/card_view/component/mortgage_dialog.dart';
import 'package:mtgpro/app/modules/card_view/component/video_view.dart';
import 'package:mtgpro/app/modules/card_view/component/view_credit_authorization.dart';
import 'package:mtgpro/app/modules/card_view/component/view_dialogs.dart';
import 'package:mtgpro/app/modules/card_view/component/view_quick_application.dart';
import 'package:mtgpro/app/modules/card_view/controller/card_view_controller.dart';
import 'package:mtgpro/app/modules/home_cards/controller/home_cards_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import 'component/cardview_profile_container.dart';

class CardViewScreen extends GetView<CardViewController> {
  CardViewScreen({Key? key}) : super(key: key);

  final HomeCardsController homeCardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.stateStatus == StateStatus.LOADING
            ? const PageLoader()
            : controller.stateStatus == StateStatus.FAILURE
                ? Center(
                    child: Text(controller.errorText.value),
                  )
                : SafeArea(
                  child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverToBoxAdapter(
                          child: CardViewProfileContainer(cardPreviewModel: controller.cardData!),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${controller.cardData?.title}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${controller.cardData?.designation} at ${controller.cardData?.companyName}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${controller.cardData?.location}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    "${controller.cardData?.bio}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 48,
                                        child: OutlinedButton.icon(
                                          icon: const Icon(
                                            Icons.file_download,
                                            size: 24,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.mainColor,
                                              foregroundColor: Colors.white,
                                              shape: const StadiumBorder(),
                                              side: const BorderSide(color: ashColor)),
                                          onPressed: () {
                                            print("${controller.cardData?.phoneNumber}");
                                            controller.downloadContacts();
                                            // controller.saveAsContact(context, "${controller.cardData?.phoneNumber}", "${controller.cardData?.title}");
                                            // Utils.appLaunchUrl('file:sdcard/download/1.vcf');
                                            // controller.createVcf();
                                            // return;
                                            // controller.shareAllVCFCard(context, vCard: controller.createVcf());
                                          },
                                          label: const Text(
                                            "Save Contacts",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 48,
                                        child: OutlinedButton.icon(
                                          icon: const Icon(
                                            Icons.share,
                                            size: 24,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.mainColor,
                                              foregroundColor: Colors.white,
                                              shape: const StadiumBorder(),
                                              side: const BorderSide(color: ashColor)),
                                          onPressed: () async {
                                            Utils.loadingDialog(context);
                                            controller.viewQrImage("${RemoteUrls.baseUrl}qr/${controller.cardData?.cardId}", '${controller.cardData?.cardId}').then((value) {
                                              print(value.path);
                                              Utils.closeDialog(context);
                                              CardViewDialogs.share(context,value.path);
                                            });
                                          },
                                          label: const Text(
                                            "Share",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          sliver: SliverToBoxAdapter(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                ...List.generate(controller.cardData!.contacts.length + 1, (index) {
                                  if (index == 0) {
                                    return InkWell(
                                      onTap: () {
                                        MortgageDialog.openMortgageCalculator(context, controller.cardData!);
                                      },
                                      child: SizedBox(
                                        width: (MediaQuery.of(context).size.width - 52) / 3,
                                        height: (MediaQuery.of(context).size.width - 52) / 3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: HexColor.fromHex(controller.cardData!.themeColor),
                                                  borderRadius: BorderRadius.circular(6)),
                                              child: SvgPicture.network('https://www.mtgpro.me/assets/img/icon/calendar-symbol.svg',height: 40,width: 40,placeholderBuilder: (context) => Icon(Icons.error,color: Colors.white),),
                                              // child: FaIcon(
                                              //   Utils.getSocialIcon("facebook"),
                                              //   color: Colors.white,
                                              //   size: 34,
                                              // ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            const Text(
                                              "Mortgage Calculator",
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  final socialIcon = controller.cardData?.contacts[index-1];
                                  if (socialIcon?.icon == "embeddedvideo") {
                                    if (socialIcon?.content == null || socialIcon?.content == "") {
                                      return const SizedBox();
                                    }
                                    if (!socialIcon!.content.contains("youtube.com")) {
                                      return const SizedBox();
                                    }
                                    return SizedBox(
                                      width: (MediaQuery.of(context).size.width - 32),
                                      height: (MediaQuery.of(context).size.width * 0.7 - 32),
                                      child: VideoView(url: socialIcon.content),
                                    );
                                  }
                                  return InkWell(
                                    onTap: () {
                                      controller.clickLink(socialIcon!);
                                    },
                                    child: SizedBox(
                                      width: (MediaQuery.of(context).size.width - 52) / 3,
                                      height: (MediaQuery.of(context).size.width - 52) / 3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          LayoutBuilder(
                                            builder: (p0, p1) {
                                              if (socialIcon?.iconImage.split(".").toList().last == "svg") {
                                                return Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: controller.cardData?.colorLink == 1 ? HexColor.fromHex(controller.cardData!.themeColor) : socialIcon?.iconColor == null || socialIcon?.iconColor == '' ? Colors.blue : HexColor.fromHex(socialIcon!.iconColor),
                                                      borderRadius: BorderRadius.circular(6)),
                                                  child: SvgPicture.network('${RemoteUrls.rootUrl}${socialIcon?.iconImage}',height: 40,width: 40,),
                                                );
                                              } else {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.circular(6),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                        color: controller.cardData?.colorLink == 1 ? HexColor.fromHex(controller.cardData!.themeColor) : socialIcon?.iconColor == null || socialIcon?.iconColor == '' ? Colors.blue : HexColor.fromHex(socialIcon!.iconColor),
                                                        borderRadius: BorderRadius.circular(6)),
                                                    child: CustomImage(path: '${RemoteUrls.rootUrl}${socialIcon?.iconImage}',height: 60,width: 60,fit: BoxFit.cover,),
                                                  ),
                                                );
                                              }
                                            },
                                          ),

                                          // Container(
                                          //   padding: const EdgeInsets.all(10),
                                          //   decoration: BoxDecoration(
                                          //       color: controller.cardData?.colorLink == 1 ? HexColor.fromHex(controller.cardData!.themeColor) : socialIcon?.iconColor == null || socialIcon?.iconColor == '' ? Colors.blue : HexColor.fromHex(socialIcon!.iconColor),
                                          //       borderRadius: BorderRadius.circular(6)),
                                          //   child: SvgPicture.network('${RemoteUrls.rootUrl}${socialIcon?.iconImage}',height: 40,width: 40,),
                                          // ),

                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "${socialIcon?.label}",
                                            maxLines: 2,
                                            style: const TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        // SliverPadding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 16, vertical: 16),
                        //   sliver: SliverGrid(
                        //     gridDelegate:
                        //         const SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 3,
                        //       crossAxisSpacing: 10,
                        //       mainAxisSpacing: 10,
                        //     ),
                        //     delegate: SliverChildBuilderDelegate((context, index) {
                        //           if (index == 0) {
                        //             return InkWell(
                        //               onTap: () {
                        //                 MortgageDialog.openMortgageCalculator(context, controller.cardData!);
                        //               },
                        //               child: Column(
                        //                 mainAxisAlignment: MainAxisAlignment.start,
                        //                 crossAxisAlignment: CrossAxisAlignment.center,
                        //                 children: [
                        //                   Container(
                        //                     padding: const EdgeInsets.all(10),
                        //                     decoration: BoxDecoration(
                        //                         color: HexColor.fromHex(controller.cardData!.themeColor),
                        //                         borderRadius: BorderRadius.circular(6)),
                        //                     child: SvgPicture.network('https://www.mtgpro.me/assets/img/icon/calendar-symbol.svg',height: 40,width: 40,placeholderBuilder: (context) => Icon(Icons.error,color: Colors.white),),
                        //                     // child: FaIcon(
                        //                     //   Utils.getSocialIcon("facebook"),
                        //                     //   color: Colors.white,
                        //                     //   size: 34,
                        //                     // ),
                        //                   ),
                        //                   const SizedBox(
                        //                     height: 6,
                        //                   ),
                        //                   const Text(
                        //                     "Mortgage Calculator",
                        //                     maxLines: 2,
                        //                     textAlign: TextAlign.center,
                        //                     style: TextStyle(fontSize: 13),
                        //                   )
                        //                 ],
                        //               ),
                        //             );
                        //           }
                        //           final socialIcon = controller.cardData?.contacts[index-1];
                        //       return InkWell(
                        //         onTap: () {
                        //           controller.clickLink(socialIcon!);
                        //         },
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             LayoutBuilder(
                        //               builder: (p0, p1) {
                        //                 if (socialIcon?.iconImage.split(".").toList().last == "svg") {
                        //                   return Container(
                        //                     padding: const EdgeInsets.all(10),
                        //                     decoration: BoxDecoration(
                        //                         color: controller.cardData?.colorLink == 1 ? HexColor.fromHex(controller.cardData!.themeColor) : socialIcon?.iconColor == null || socialIcon?.iconColor == '' ? Colors.blue : HexColor.fromHex(socialIcon!.iconColor),
                        //                         borderRadius: BorderRadius.circular(6)),
                        //                     child: SvgPicture.network('${RemoteUrls.rootUrl}${socialIcon?.iconImage}',height: 40,width: 40,),
                        //                   );
                        //                 } else {
                        //                   return ClipRRect(
                        //                     borderRadius: BorderRadius.circular(6),
                        //                     child: Container(
                        //                       padding: const EdgeInsets.all(0),
                        //                       decoration: BoxDecoration(
                        //                           color: controller.cardData?.colorLink == 1 ? HexColor.fromHex(controller.cardData!.themeColor) : socialIcon?.iconColor == null || socialIcon?.iconColor == '' ? Colors.blue : HexColor.fromHex(socialIcon!.iconColor),
                        //                           borderRadius: BorderRadius.circular(6)),
                        //                       child: CustomImage(path: '${RemoteUrls.rootUrl}${socialIcon?.iconImage}',height: 60,width: 60,fit: BoxFit.cover,),
                        //                     ),
                        //                   );
                        //                 }
                        //               },
                        //             ),
                        //
                        //             // Container(
                        //             //   padding: const EdgeInsets.all(10),
                        //             //   decoration: BoxDecoration(
                        //             //       color: controller.cardData?.colorLink == 1 ? HexColor.fromHex(controller.cardData!.themeColor) : socialIcon?.iconColor == null || socialIcon?.iconColor == '' ? Colors.blue : HexColor.fromHex(socialIcon!.iconColor),
                        //             //       borderRadius: BorderRadius.circular(6)),
                        //             //   child: SvgPicture.network('${RemoteUrls.rootUrl}${socialIcon?.iconImage}',height: 40,width: 40,),
                        //             // ),
                        //
                        //             const SizedBox(
                        //               height: 6,
                        //             ),
                        //             Text(
                        //               "${socialIcon?.label}",
                        //               maxLines: 2,
                        //               style: const TextStyle(fontSize: 13),
                        //             )
                        //           ],
                        //         ),
                        //       );
                        //     }, childCount: controller.cardData!.contacts.length + 1),
                        //   ),
                        // ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          sliver: SliverToBoxAdapter(
                            child: Wrap(
                              children: [
                                Visibility(
                                  visible: homeCardController.userInfo?.disclaimerView == 1,
                                  child: SizedBox(
                                    height: (MediaQuery.of(context).size.width - 52) / 3,
                                    width: (MediaQuery.of(context).size.width - 52) / 3,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context, builder: (context) => AlertDialog(
                                          title: const Text('Disclaimer'),
                                          content: SizedBox(
                                            // child: Text("${homeCardController.userInfo?.userDisclaimer}"),
                                            child: HtmlWidget(
                                              "${homeCardController.userInfo?.userDisclaimer}"
                                            ),
                                          ),
                                        ),);
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: HexColor.fromHex(controller.cardData!.themeColor),
                                                borderRadius: BorderRadius.circular(6)),
                                            child: SvgPicture.network('https://www.mtgpro.me/assets/img/icon/notes-note.svg',height: 40,width: 40,placeholderBuilder: (context) => Icon(Icons.error,color: Colors.white),),
                                            // child: FaIcon(
                                            //   Utils.getSocialIcon("facebook"),
                                            //   color: Colors.white,
                                            //   size: 34,
                                            // ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const Text(
                                            "Disclaimer",
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: homeCardController.userInfo?.housingLogoView == 1,
                                  child: SizedBox(
                                    height: (MediaQuery.of(context).size.width - 52) / 3,
                                    width: (MediaQuery.of(context).size.width - 52) / 3,
                                    child: InkWell(
                                      onTap: () {
                                        Utils.appLaunchUrl("https://nmlsconsumeraccess.org");
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius: BorderRadius.circular(6)),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: Colors.white,),
                                                child: Image(image: AssetImage("assets/images/housing.png"),height: 40,width: 40,)),
                                            // child: SvgPicture.network('https://www.mtgpro.me/assets/img/house.png',height: 40,width: 40,placeholderBuilder: (context) => Icon(Icons.error,color: Colors.white),),
                                            // child: Image.network('https://images.squarespace-cdn.com/content/v1/5c9bd64051f4d48c8f2ec33c/1554653929152-8SRY43EFHFDT5DLCC5ZC/equal-housing-opportunity-logo-fair-housing-and-equal-opportunity-boulder-housing-partners-free.png',height: 40,width: 40,errorBuilder: (context, error, stackTrace) => Icon(Icons.error,color: Colors.white),),
                                            // child: FaIcon(
                                            //   Utils.getSocialIcon("facebook"),
                                            //   color: Colors.white,
                                            //   size: 34,
                                            // ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const Text(
                                            "Equal Housing Opportunity",
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: homeCardController.userInfo?.creditAuthorization == 1,
                                  child: SizedBox(
                                    height: (MediaQuery.of(context).size.width - 52) / 3,
                                    width: (MediaQuery.of(context).size.width - 52) / 3,
                                    child: InkWell(
                                      onTap: () {
                                        ViewCreditAuthorizationDialog.creditAuthorization(context,controller.cardData!);
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius: BorderRadius.circular(6)),
                                            child: const Icon(Icons.verified_user_outlined,color: Colors.white,size: 40,),
                                            // child: SvgPicture.network('https://www.mtgpro.me/assets/img/icon/craditauthorization.svg',height: 40,width: 40,placeholderBuilder: (context) => Icon(Icons.error,color: Colors.white),),
                                            // child: Image.network('https://www.mtgpro.me/assets/img/icon/craditauthorization.svg',height: 40,width: 40,errorBuilder: (context, error, stackTrace) => const Icon(Icons.error,color: Colors.white),),
                                            // child: FaIcon(
                                            //   Utils.getSocialIcon("facebook"),
                                            //   color: Colors.white,
                                            //   size: 34,
                                            // ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const Text(
                                            "Credit Authorization",
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: homeCardController.userInfo?.quickApplication == 1,
                                  child: SizedBox(
                                    height: (MediaQuery.of(context).size.width - 52) / 3,
                                    width: (MediaQuery.of(context).size.width - 52) / 3,
                                    child: InkWell(
                                      onTap: () {
                                        ViewQuickApplicationDialog.quickApplication(context,controller.cardData!);
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.teal,
                                                borderRadius: BorderRadius.circular(6)),
                                            child: SvgPicture.network('https://www.mtgpro.me/assets/img/icon/rules.svg',height: 40,width: 40,placeholderBuilder: (context) => Icon(Icons.error,color: Colors.white),),
                                            // child: FaIcon(
                                            //   Utils.getSocialIcon("facebook"),
                                            //   color: Colors.white,
                                            //   size: 34,
                                            // ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const Text(
                                            "Quick Application",
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SliverPadding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          sliver: SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                  "Copyright © MTGPRO.ME. All rights reserved.",textAlign: TextAlign.center,),
                            ),
                          ),
                        ),

                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          sliver: SliverToBoxAdapter(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.black87,),
                              ),
                              child: Column(
                                children: const [
                                  SizedBox(
                                    child: Text("MTGPRO.ME is a digital business card solution for mortgage professionals owned by Non-QM Doc LLC. ",textAlign: TextAlign.center,),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    child: Text("Non-QM Doc LLC is not NMLS Licensed and does not provide lending services.",textAlign: TextAlign.center,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          sliver: SliverToBoxAdapter(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.mainColor,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    CardViewDialogs.contactWithMe(context, controller.cardData!);
                                  },
                                  child: const Text("Contact with me")),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
      ),
    );
  }
}
