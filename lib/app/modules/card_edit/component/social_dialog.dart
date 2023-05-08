import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtgpro/app/core/utils/extensions.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/data/remote_urls.dart';
import 'package:mtgpro/app/modules/card_edit/controller/card_edit_controller.dart';
import 'package:mtgpro/app/modules/home_cards/model/social_link_model.dart';

import '../../../core/utils/constants.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../../global_widgets/helper_text.dart';
import 'package:get/get.dart';

import 'icon_widget.dart';

class SocialDialog {
  void chooseSocialLink(context){
    final MtgCardEditController cardEditController = Get.find();
    final socialLinks = cardEditController.homeCardsController.socialLinkCategories;
    showModalBottomSheet(
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
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              minChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
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
                    Expanded(
                      child: CustomScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 16,
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            sliver: SliverToBoxAdapter(
                              child: HelperText().boldText18("Add Content"),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            sliver: SliverToBoxAdapter(
                              child: Text("Select from our wide variety of links and contact info below. (${cardEditController.homeCardsController.socialLinks.length})"),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(socialLinks[index].title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                    GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      childAspectRatio: 3/1,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      children: [
                                        ...List.generate(socialLinks[index].socialLinks.length, (linkIndex) {
                                          return Material(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.of(context).pop();
                                                socialLinkInputDialog(socialLinks[index].socialLinks[linkIndex],context);
                                              },
                                              borderRadius: BorderRadius.circular(16),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    // FaIcon(Utils.getSocialIcon(socialNameList[index].socialMedia),color: Utils.getSocialIconColor(socialNameList[index].socialMedia),),
                                                    // CustomImage(path: '${RemoteUrls.rootUrl}${socialLinks[index].socialLinks[linkIndex].iconImage}',height: 30,width: 30,),
                                                    // Image.network('${RemoteUrls.rootUrl}${socialLinks[index].socialLinks[linkIndex].iconImage}',height: 24,width: 24,),
                                                    Container(
                                                      padding: const EdgeInsets.all(3),
                                                      decoration: BoxDecoration(
                                                        color: socialLinks[index].socialLinks[linkIndex].iconColor != ''
                                                            ? HexColor.fromHex(socialLinks[index].socialLinks[linkIndex].iconColor)
                                                            : Colors.black87,
                                                        borderRadius: BorderRadius.circular(4)
                                                      ),
                                                        child: SvgPicture.network('${RemoteUrls.rootUrl}${socialLinks[index].socialLinks[linkIndex].iconImage}',
                                                          height: 24,width: 24,)
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    // Text(socialNameList[index].socialMedia,style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                                                    Expanded(
                                                      child: Text(socialLinks[index].socialLinks[linkIndex].iconTitle,
                                                        maxLines: 1,
                                                        style: const TextStyle(color: Colors.black,
                                                            fontSize: 13,fontWeight: FontWeight.w400),),
                                                    ),
                                                    // const Spacer(),
                                                    Material(
                                                      color: boxTextFieldColor,
                                                      shape: const CircleBorder(),
                                                      child: InkWell(
                                                        onTap: (){
                                                          Navigator.of(context).pop();
                                                          socialLinkInputDialog(socialLinks[index].socialLinks[linkIndex],context);
                                                        },
                                                        borderRadius: BorderRadius.circular(50),
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(4),
                                                          child: Center(child: Icon(Icons.add)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    )
                                  ],
                                );
                              },childCount: socialLinks.length),
                            ),
                          )
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

  void socialLinkInputDialog(SocialLinkModel socialLinkModel,context){
    final key = GlobalKey<FormState>();
    var titleController = TextEditingController(text: socialLinkModel.iconTitle);
    var linkController = TextEditingController(text: socialLinkModel.mainLink);
    final MtgCardEditController controller = Get.find();
    showModalBottomSheet(
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
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              minChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
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
                    Expanded(
                      child: CustomScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 16,
                            ),
                          ),

                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            sliver: SliverToBoxAdapter(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                      chooseSocialLink(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.arrow_back),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Back"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Material(
                                    color: Colors.white,
                                    shape: const CircleBorder(),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                            sliver: SliverToBoxAdapter(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    height: 50,width: 50,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: socialLinkModel.iconColor != ''
                                            ? HexColor.fromHex(socialLinkModel.iconColor)
                                            : Colors.black87,
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: SvgPicture.network('${RemoteUrls.rootUrl}${socialLinkModel.iconImage}',
                                      height: 50,width: 50,)
                                ),
                              ),
                              // child: FaIcon(Utils.getSocialIcon(socialMedia.socialMedia),size: 50,color: Utils.getSocialIconColor(socialMedia.socialMedia),),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                            sliver: SliverToBoxAdapter(
                              child: Form(
                                key: key,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: HelperText().normalText(socialLinkModel.type.firstCapitalize())
                                    ),
                                    const SizedBox(height: 8,),
                                    CustomEditText().boxEditText(linkController, '', socialLinkModel.type, controller.getValidator(socialLinkModel.type.getIconType(socialLinkModel.type)), controller.getInputType(socialLinkModel.type.getIconType(socialLinkModel.type)),Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: HelperText().normalText("Link Title"),
                                    ),
                                    const SizedBox(height: 8,),
                                    CustomEditText().boxEditText(titleController, '', "title", Helper.validationAverage, TextInputType.text,Colors.white),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 45,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(shape: const StadiumBorder(),side: BorderSide(color: AppColors.mainColor)),
                                              onPressed: (){},
                                              child: Text("Cancel",style: TextStyle(fontSize: 14,color: AppColors.mainColor),),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 48,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: const StadiumBorder(),side: BorderSide(color: AppColors.mainColor,style: BorderStyle.solid)),
                                              onPressed: (){
                                                if (key.currentState!.validate()) {
                                                  key.currentState!.save();
                                                  Navigator.pop(context);
                                                  controller.cardAddSocialToApi(socialLinkModel.copyWith(mainLink: linkController.text.trim(),iconName: titleController.text.trim(),iconTitle: titleController.text));
                                                  // return;
                                                  // Utils.loadingDialog(context);
                                                  // Future.delayed(const Duration(seconds: 2)).then((value) {
                                                  //   Utils.closeDialog(context);
                                                  //   controller.addSocialLinks(SocialMedias(id: socialMedia.id, socialMedia: titleController.text, url: linkController.text));
                                                  //   Navigator.of(context).pop();
                                                  // });

                                                }
                                              },
                                              child: Text("Save",style: TextStyle(fontSize: 14,color: AppColors.white),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 500,
                                    )
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

  void socialLinkUpdateDialog(
      final SocialLinkModel socialLinkModel,
      final BuildContext context,
      final ValueChanged<SocialLinkModel> onDelete,
      final ValueChanged<SocialLinkModel> onUpdate){
    final key = GlobalKey<FormState>();
    var titleController = TextEditingController(text: socialLinkModel.iconTitle);
    var linkController = TextEditingController(text: socialLinkModel.mainLink);
    final MtgCardEditController controller = Get.find();
    showModalBottomSheet(
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
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              minChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
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
                    Expanded(
                      child: CustomScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 16,
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            sliver: SliverToBoxAdapter(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(),
                                    const Spacer(),
                                    Material(
                                      color: Colors.white,
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                        borderRadius: BorderRadius.circular(50),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                            sliver: SliverToBoxAdapter(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: CardIconWidget(icon: socialLinkModel.iconImage, iconColor: socialLinkModel.iconColor,size: 50,),
                                // child: Container(
                                //     height: 50,width: 50,
                                //     padding: const EdgeInsets.all(6),
                                //     decoration: BoxDecoration(
                                //         color: socialLinkModel.iconColor != ''
                                //             ? HexColor.fromHex(socialLinkModel.iconColor)
                                //             : Colors.black87,
                                //         borderRadius: BorderRadius.circular(4)
                                //     ),
                                //     child: SvgPicture.network('${RemoteUrls.rootUrl}${socialLinkModel.iconImage}',
                                //       height: 50,width: 50,)
                                // ),
                              ),
                              // child: FaIcon(Utils.getSocialIcon(socialMedia.socialMedia),size: 50,color: Utils.getSocialIconColor(socialMedia.socialMedia),),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                            sliver: SliverToBoxAdapter(
                              child: Form(
                                key: key,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: HelperText().normalText(socialLinkModel.type.firstCapitalize()),
                                    ),
                                    const SizedBox(height: 8,),
                                    CustomEditText().boxEditText(linkController, '', socialLinkModel.type, controller.getValidator(socialLinkModel.type.getIconType(socialLinkModel.type)), controller.getInputType(socialLinkModel.type.getIconType(socialLinkModel.type)),Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: HelperText().normalText("Link Title"),
                                    ),
                                    const SizedBox(height: 8,),
                                    CustomEditText().boxEditText(titleController, '', "title", Helper.validationAverage, TextInputType.text,Colors.white),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 45,
                                            child: TextButton.icon(
                                              style: TextButton.styleFrom(shape: const StadiumBorder(),foregroundColor: Colors.red,side: const BorderSide(color: Colors.red)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                onDelete(socialLinkModel);
                                              },
                                              icon: const Icon(Icons.delete),
                                              label: const Text("Remove",style: TextStyle(fontSize: 14,color: Colors.red),),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 45,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(shape: const StadiumBorder(),side: BorderSide(color: AppColors.mainColor)),
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Cancel",style: TextStyle(fontSize: 14,color: AppColors.mainColor),),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 48,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: const StadiumBorder(),side: BorderSide(color: AppColors.mainColor,style: BorderStyle.solid)),
                                              onPressed: (){
                                                if (key.currentState!.validate()) {
                                                  key.currentState!.save();
                                                  Navigator.pop(context);
                                                  SocialLinkModel link = socialLinkModel.copyWith(mainLink: linkController.text.trim(),iconName: titleController.text.trim(),iconTitle: titleController.text);
                                                  onUpdate(link);
                                                  // controller.cardAddSocialToApi(socialLinkModel.copyWith(mainLink: linkController.text.trim(),iconName: titleController.text.trim()));
                                                  // return;
                                                  // Utils.loadingDialog(context);
                                                  // Future.delayed(const Duration(seconds: 2)).then((value) {
                                                  //   Utils.closeDialog(context);
                                                  //   controller.addSocialLinks(SocialMedias(id: socialMedia.id, socialMedia: titleController.text, url: linkController.text));
                                                  //   Navigator.of(context).pop();
                                                  // });

                                                }
                                              },
                                              child: Text("Update",style: TextStyle(fontSize: 14,color: AppColors.white),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 500,
                                    )
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
}

