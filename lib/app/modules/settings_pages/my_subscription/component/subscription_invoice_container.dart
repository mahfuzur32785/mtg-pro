import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtgpro/app/animation/custom_delayed_animation.dart';
import 'package:mtgpro/app/data/enums/state_status.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/component/invoice_card.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/controller/subscription_controller.dart';

class InvoiceContainer extends GetView<SubscriptionController> {
  InvoiceContainer({Key? key}) : super(key: key);
  bool isTap = false;
  void _onTapDown(TapDownDetails details) {
    // setState(() {
    //   isTap = true;
    // });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      // setState(() {
      //   isTap = false;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.invoiceStateStatus == StateStatus.LOADING
        ? const SizedBox()
        : CustomDelayedAnimation(
            dy: 0.1,
            dx: 0,
            delay: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(-5, -5)),
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(5, 5)),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Invoice History",
                        style: GoogleFonts.merriweatherSans(),
                      ),
                      // GestureDetector(
                      //     onTapDown: _onTapDown,
                      //     onTapUp: _onTapUp,
                      //     child: Row(
                      //       children: [
                      //         Icon(Icons.download,
                      //             size: 24,
                      //             color: isTap ? Colors.black87 : Colors.blue),
                      //         const SizedBox(
                      //           width: 3,
                      //         ),
                      //         Text(
                      //           "Download All",
                      //           style: TextStyle(
                      //               color: isTap ? Colors.black87 : Colors.blue,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //       ],
                      //     ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                      child:
                          Text("Here are your previous invoices and receipts")),
                  const Divider(
                    height: 30,
                  ),
                  ...List.generate(
                      controller.invoiceList.length,
                      (index) => InvoiceCard(
                        invoiceModel: controller.invoiceList[index],
                            index: index,
                          ))
                ],
              ),
            ),
          ));
  }
}
