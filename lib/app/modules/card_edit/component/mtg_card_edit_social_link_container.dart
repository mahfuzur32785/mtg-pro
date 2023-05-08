import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/card_edit/component/icon_widget.dart';
import 'package:mtgpro/app/modules/card_edit/component/social_dialog.dart';
import 'package:mtgpro/app/modules/card_edit/controller/card_edit_controller.dart';
import 'package:mtgpro/app/modules/home_cards/model/social_link_model.dart';

import '../../../core/utils/extensions.dart';
import '../../../data/remote_urls.dart';

class MtgCardEditSocialLinkContainer extends GetView<MtgCardEditController> {
  MtgCardEditSocialLinkContainer({Key? key}) : super(key: key);

  SocialDialog socialDialog = SocialDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              HelperText().boldText("Content"),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor),
                onPressed: () {
                  socialDialog.chooseSocialLink(context);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  "Add Links and Contact Info",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(() => controller.socialLinks.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: ashColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Material(
                      color: ashColor,
                      borderRadius: BorderRadius.circular(6),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: (){
                          socialDialog.socialLinkUpdateDialog(
                            controller.socialLinks[index],
                            context,
                                (deleteValue) async {
                            Utils.loadingDialog(context);
                            final result = await controller.deleteIconFromCard(controller.socialLinks[index].cardFieldId);
                            result.fold((error) {
                              Future.delayed(const Duration(seconds: 1)).then((value) {
                                Utils.closeDialog(context);
                                Helper.toastMsg(error.message);
                              });
                            }, (data) {
                              Future.delayed(const Duration(seconds: 1)).then((value) {
                                Utils.closeDialog(context);
                                Helper.toastMsg(data);
                                controller.socialLinks.removeAt(index);
                              });
                            });
                          },
                            (updateSocialLink) async {
                              Utils.loadingDialog(context);
                              final result = await controller.editSocialIcon(updateSocialLink);
                              result.fold((error) {
                                Future.delayed(const Duration(seconds: 1)).then((value) {
                                  Utils.closeDialog(context);
                                  Helper.toastMsg(error.message);
                                });
                              }, (data) {
                                Future.delayed(const Duration(seconds: 1)).then((value) {
                                  Utils.closeDialog(context);
                                  Helper.toastMsg(data);
                                  controller.socialLinks[index] = updateSocialLink;
                                });

                              });
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 6, bottom: 6, left: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              CardIconWidget(icon: controller.socialLinks[index].iconImage, iconColor: controller.socialLinks[index].iconColor,size: 30,),
                              // Obx(() => controller.socialLinks[index].iconImage.split(".").toList().last == "svg"
                              //     ? Container(
                              //     padding: const EdgeInsets.all(6),
                              //     decoration: BoxDecoration(
                              //         color: controller.socialLinks[index].iconColor != ''
                              //             ? HexColor.fromHex(controller.socialLinks[index].iconColor)
                              //             : Colors.black87,
                              //         borderRadius: BorderRadius.circular(4)
                              //     ),
                              //     child: SvgPicture.network('${RemoteUrls.rootUrl}${controller.socialLinks[index].iconImage}', height: 24,width: 24,)
                              // )
                              //     : ClipRRect(
                              //   borderRadius: BorderRadius.circular(4),
                              //       child: Container(
                              //       padding: const EdgeInsets.all(0),
                              //       decoration: BoxDecoration(
                              //           color: controller.socialLinks[index].iconColor != ''
                              //               ? HexColor.fromHex(controller.socialLinks[index].iconColor)
                              //               : Colors.black87,
                              //           borderRadius: BorderRadius.circular(4)
                              //       ),
                              //       child: CustomImage(path: "${RemoteUrls.rootUrl}${controller.socialLinks[index].iconImage}",height: 30,width: 30,fit: BoxFit.cover,)
                              // ),
                              //     )
                              // ),

                              const SizedBox(
                                width: 16,
                              ),
                              Text(controller.socialLinks[index].iconTitle),
                              const Spacer(),
                              Obx(() {
                                  return Switch(
                                      value: controller.socialLinks[index].status == 1,
                                      activeColor: AppColors.mainColor,
                                      onChanged: (value) async {
                                        SocialLinkModel link = controller.socialLinks[index].copyWith(status: value ? 1 : 0);
                                        controller.socialLinks[index] = link;
                                        final result = await controller.editSocialIcon(controller.socialLinks[index]);
                                        result.fold((error) {
                                          Helper.toastMsg(error.message);
                                          SocialLinkModel link = controller.socialLinks[index].copyWith(status: value ? 0 : 1);
                                          controller.socialLinks[index] = link;
                                        }, (data) {
                                          Helper.toastMsg(data);
                                        });
                                      });
                                }
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: controller.socialLinks.length,
                  physics: const NeverScrollableScrollPhysics(),
                ))
        ],
      ),
    );
  }
}
