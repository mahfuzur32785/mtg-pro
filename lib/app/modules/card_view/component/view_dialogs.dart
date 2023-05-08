import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mtgpro/app/global_widgets/download_method.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/card_view/controller/card_view_controller.dart';

import '../../../core/utils/constants.dart';
import '../../../data/remote_urls.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../home_cards/controller/home_cards_controller.dart';
import '../model/card_preview_model.dart';

class CardViewDialogs {
  static share(context,String qrPath){
    final CardViewController controller = Get.find();
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
              initialChildSize: 0.8,
              maxChildSize: 0.8,
              minChildSize: 0.8,
              expand: false,
              builder: (context, scrollController) {
                return CustomScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Center(child: Text("Send Card",style: TextStyle(fontSize: 18,),)),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Image(image:  FileImage(File(qrPath)),height: 200,width: 200,),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      sliver: SliverGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3/1,
                        children: [
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: () async {
                                // goDownload(context: context, downloadUrl: "${RemoteUrls.rootUrl}qr/${controller.cardData?.cardId}", fileName: "${controller.cardData?.title}${controller.cardData?.cardId}");
                                // return;

                                final result = await controller.downloadFile("${RemoteUrls.baseUrl}qr/${controller.cardData?.cardId}", '${controller.cardData?.cardId}');
                                result.fold((error) {
                                  Helper.toastMsg(error.message);
                                }, (path) {
                                  Helper.toastMsg("Qr Image downloaded");
                                });

                                // Utils.appLaunchUrl("http://192.168.203.60:8000/api/qr/63e9bd65607f7");
                                // Client client = Client();
                                // final result = await client.get(Uri.parse("http://192.168.203.60:8000/api/qr/63e9bd65607f7"));
                                // print(result.body);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.download,size: 20,color: AppColors.mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Download QR",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: () async {
                                Share.share(
                                    '${RemoteUrls.rootUrl}${controller.cardData?.cardUrl}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Everisamting product');
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.link,size: 20,color: AppColors.mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Social Media",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                var body = 'Hi there! Please click this link to check out my professional business card ${RemoteUrls.rootUrl}${controller.cardData?.cardUrl}';
                                Utils.appLaunchTextSMS(body);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.commentDots,size: 20,color: AppColors.mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Text",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                var body = 'Hi there! Please click this link to check out my professional business card ${RemoteUrls.rootUrl}${controller.cardData?.cardUrl}';
                                Utils.appLaunchEmail(body);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.envelope,size: 20,color: AppColors.mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Email",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
          );
        }
    );
  }

  static shareFromHome(context,CardModel cardModel, String qrPath){
    final HomeCardsController homeCardsController = Get.find();
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
              initialChildSize: 0.8,
              maxChildSize: 0.8,
              minChildSize: 0.8,
              expand: false,
              builder: (context, scrollController) {
                return CustomScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Center(child: Text("Scan Card",style: TextStyle(fontSize: 18,),)),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Image(image:  FileImage(File(qrPath)),height: 300,width: 300,),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Center(child: Text("Share the card",style: TextStyle(fontSize: 18,),)),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      sliver: SliverGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3/1,
                        children: [
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: () async {
                                Share.share(
                                    '${RemoteUrls.rootUrl}${homeCardsController.userInfo?.username}',
                                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                                    subject:
                                    'Click bellow the link to share Everisamting product');
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.link,size: 20,color: AppColors.mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Social Media",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                var body = 'Hi there! Please click this link to check out my professional business card ${RemoteUrls.rootUrl}${homeCardsController.userInfo?.username}';
                                Utils.appLaunchTextSMS(body);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.commentDots,size: 20,color: AppColors.mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Text",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
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
                                var body = 'Hi there! Please click this link to check out my professional business card ${RemoteUrls.rootUrl}${homeCardsController.userInfo?.username}';
                                Utils.appLaunchEmail(body);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(FontAwesomeIcons.envelope,size: 20,color: AppColors.mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Email",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
          );
        }
    );
  }

  static contactWithMe(context,CardPreviewModel cardPreviewModel,){
    final CardViewController controller = Get.find();

    final formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var jobTitleController = TextEditingController();
    var companyController = TextEditingController();
    var noteController = TextEditingController();

    bool isLoading = false;

    return showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFFFFFFF),
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
              minChildSize: 0.5,
              expand: false,
              builder: (context, scrollController) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return CustomScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      slivers: [
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 16,
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          sliver: SliverToBoxAdapter(
                            child: Center(child: Text("Share your info back with ${cardPreviewModel.title}",style: const TextStyle(fontSize: 18,),)),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 16,
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                          sliver: SliverToBoxAdapter(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  CustomEditText().boxEditText(nameController,
                                      '',
                                      "Name",
                                      Helper.validationAverage,
                                      TextInputType.text, Colors.white),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomEditText().boxEditText(emailController,
                                      '',
                                      "Email",
                                      Helper.validationEmail,
                                      TextInputType.emailAddress, Colors.white),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomEditText().boxEditText(phoneController,
                                      '',
                                      "Phone Number",
                                      Helper.validationAverage,
                                      TextInputType.number, Colors.white),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomEditText().boxEditText(jobTitleController,
                                      '',
                                      "Job Title",
                                      Helper.validationAverage,
                                      TextInputType.text, Colors.white),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomEditText().boxEditText(companyController,
                                      '',
                                      "Company Name",
                                      Helper.validationAverage,
                                      TextInputType.text, Colors.white,maxLines: 1),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomEditText().boxEditText(noteController,
                                      '',
                                      "Questions,Comments or Important Details",
                                      Helper.validationAverage,
                                      TextInputType.text, Colors.white,maxLines: 4),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  LayoutBuilder(
                                      builder: (context,constraints) {
                                        if (isLoading == true) {
                                          return SizedBox(
                                            height: 24,width: 24,
                                            child: Center(
                                              child: CircularProgressIndicator(color: AppColors.mainColor,strokeWidth: 3,),
                                            ),
                                          );
                                        }
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,
                                              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                                              foregroundColor: Colors.white),
                                          onPressed: () async {
                                            if (!formKey.currentState!.validate()) {
                                              return;
                                            }

                                            Utils.closeKeyBoard(context);
                                            final body = <String, dynamic>{};
                                            body.addAll({"name": nameController.text.trim()});
                                            body.addAll({"email": emailController.text.trim()});
                                            body.addAll({"phone": phoneController.text.trim()});
                                            body.addAll({"job_title": jobTitleController.text.trim()});
                                            body.addAll({"company_name": companyController.text.trim()});
                                            body.addAll({"message": noteController.text.trim()});
                                            body.addAll({"card_id": '${cardPreviewModel.id}'});

                                            setState(() {
                                              isLoading = true;
                                            });

                                            final result = await controller.connectWithMe(body);

                                            result.fold((error) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Helper.toastMsg(error.message);
                                            }, (data) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Helper.toastMsg(data);

                                              emailController.text = '';
                                              nameController.text = '';
                                              phoneController.text = '';
                                              jobTitleController.text = '';
                                              companyController.text = '';
                                              noteController.text = '';
                                            });
                                          },
                                          child: const Text("Connect"),
                                        );
                                      }
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                );
              }
          );
        }
    );
  }
}