import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/page_refresh.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/component/billing_info_card.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/component/subscription_invoice_container.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/component/user_plan_card.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/controller/subscription_controller.dart';

import '../../../data/enums/state_status.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRefresh(
      onTap: () => controller.pageRefresh(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Subscription",style: TextStyle(color: Colors.black87),),
          foregroundColor: Colors.black87,
        ),
        body: Obx(() => controller.stateStatus == StateStatus.LOADING ? const Center(
          child: CircularProgressIndicator(),
        ) : CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            // SliverToBoxAdapter(
            //   child: CurrentContainer(),
            // ),
            const SliverToBoxAdapter(
              child: UserPlanCard(),
            ),
            const SliverToBoxAdapter(
              child: BillingInfoCard(),
            ),
            // SliverToBoxAdapter(
            //   child: PaymentMethodCard(),
            // ),
            SliverToBoxAdapter(
              child: InvoiceContainer(),
            ),
          ],
        )),
      ),
    );
  }
}