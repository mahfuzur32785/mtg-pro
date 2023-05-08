import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/component/order_card.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/controller/order_controller.dart';

import '../../../data/enums/state_status.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Order",style: TextStyle(color: Colors.black87),),
        foregroundColor: Colors.black87,
      ),
      body: Obx(() {
        if (controller.stateStatus == StateStatus.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.stateStatus == StateStatus.SUCCESS && controller.myOrder.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Order Not Found!",style: TextStyle(color: Colors.red.shade500,fontSize: 16,fontWeight: FontWeight.w500),),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(onPressed: (){
                  Get.back();
                }, child: const Text("Go Back"))
              ],
            ),
          );
        } else if (controller.stateStatus == StateStatus.FAILURE) {
          return Center(
            child: Text("${controller.errorText}"),
          );
        }
        return CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return OrderCard(myOrderModel: controller.myOrder[index]);
                  },
                  childCount: controller.myOrder.length,
                )
            ),
          ],
        );
      }
      ),
    );
  }

}