import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/modules/history/component/row_view.dart';
import 'package:mtgpro/app/modules/history/controller/card_qr_download_history.dart';

import '../controller/card_view_history_controller.dart';

class QrDownloadHistoryScreen extends GetView<CardQrDownloadHistoryController> {
  const QrDownloadHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().simpleAppBar("Qr Download History"),
      body: Obx(() => controller.isLoading.value ? const Center(
        child: CircularProgressIndicator(),
      ) : CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 2.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(5,5)
                      ),
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(-5,-5)
                      ),
                    ]
                ),
                child: Table(
                    border: TableBorder.all(color: Colors.black87, width: 0.5),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      // 3: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(4),
                      5: FlexColumnWidth(3),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      ...List.generate(controller.cardViewList.length + 1, (index) {
                        if (index == 0) {
                          // return RowView.dataRow("SL", "Card Title", "Number Of Visits", "Device Id", "Ip Address", "User Agent", "Address");
                          return RowView.dataRow("SL", "Card Title", "Number Of Visits", "Ip Address", "User Agent", "Address");
                        } else {
                          // return RowView.dataRow("$index", controller.cardViewList[index-1].name, "${controller.cardViewList[index-1].counter}", controller.cardViewList[index-1].deviceId, controller.cardViewList[index-1].ipAddress, controller.cardViewList[index-1].userAgent, "${controller.cardViewList[index-1].city == '' ? '' : '${controller.cardViewList[index-1].city} - '}${controller.cardViewList[index-1].countryName}");
                          return RowView.dataRow("$index", controller.cardViewList[index-1].name, "${controller.cardViewList[index-1].counter}", controller.cardViewList[index-1].ipAddress, controller.cardViewList[index-1].userAgent, "${controller.cardViewList[index-1].city == '' ? '' : '${controller.cardViewList[index-1].city} - '}${controller.cardViewList[index-1].countryName}");
                        }
                      })
                    ]
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() => controller.isLoadingMore.value
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
