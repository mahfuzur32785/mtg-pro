import 'package:flutter/material.dart';
import 'component/mtg_card_color_container.dart';
import 'component/mtg_card_form_container.dart';
import 'component/picture_container.dart';

class MtgCardCreateScreen extends StatelessWidget {
  const MtgCardCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverToBoxAdapter(
              child: MtgCardPictureContainer(),
            ),
            SliverToBoxAdapter(
              child: MtgCardColorContainer(),
            ),
            SliverToBoxAdapter(
              child: MtgCardFromContainer(),
            ),
            // SliverToBoxAdapter(
            //   child: MtgCardSocialLinkContainer(),
            // ),
          ],
        ),
      ),
    );
  }
}

