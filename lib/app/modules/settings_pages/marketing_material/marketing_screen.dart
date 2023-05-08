import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/enums/state_status.dart';
import 'component/material_card.dart';
import 'controller/marketing_controller.dart';

class MarketingScreen extends GetView<MarketingController> {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Free Marketing Material",style: TextStyle(color: Colors.black87),),
        foregroundColor: Colors.black87,
      ),
      body: Obx(() => controller.stateStatus == StateStatus.LOADING ? const Center(
        child: CircularProgressIndicator(),
      ) : CustomScrollView(
        controller: controller.scrollController,
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MarketingCard(marketMaterialModel: controller.marketMaterial[index]);
              },
              childCount: controller.marketMaterial.length,
            )
          ),
          SliverToBoxAdapter(
            child: Obx(() => controller.isLoadMoreLoading.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox()),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          )
        ],
      )),
    );
  }

}
