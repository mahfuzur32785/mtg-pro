import 'package:flutter/material.dart';
import 'package:mtgpro/app/modules/card_edit/component/mtg_card_edit_color_container.dart';
import 'package:mtgpro/app/modules/card_edit/component/mtg_card_edit_feature_container.dart';
import 'package:mtgpro/app/modules/card_edit/component/mtg_card_edit_image_container.dart';

import 'component/mtg_card_edit_form_container.dart';
import 'component/mtg_card_edit_social_link_container.dart';

class MtgCardEditScreen extends StatelessWidget {
  const MtgCardEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            const SliverToBoxAdapter(
              child: MtgCardEditPictureContainer(),
            ),
            const SliverToBoxAdapter(
              child: MtgCardEditColorContainer(),
            ),
            const SliverToBoxAdapter(
              child: MtgCardEditFromContainer(),
            ),
            const SliverToBoxAdapter(
              child: MtgCardEditExtraFeatureContainer(),
            ),
            SliverToBoxAdapter(
              child: MtgCardEditSocialLinkContainer(),
            ),
          ],
        ),
      ),
    );
  }
}

