import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:mtgpro/app/modules/card_edit/component/social_dialog.dart';

import '../controller/mtg_card_create_controller.dart';

class MtgCardSocialLinkContainer extends GetView<MtgCreateCardController> {
  MtgCardSocialLinkContainer({Key? key}) : super(key: key);

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
              padding:
              const EdgeInsets.only(top: 6, bottom: 6, left: 16),
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: ashColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  FaIcon(
                    Utils.getSocialIcon(
                        controller.socialLinks[index].socialMedia),
                    color: Utils.getSocialIconColor(
                        controller.socialLinks[index].socialMedia),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(controller.socialLinks[index].socialMedia),
                  const Spacer(),
                  Switch(
                      value: true,
                      activeColor: AppColors.mainColor,
                      onChanged: (value) {})
                ],
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
