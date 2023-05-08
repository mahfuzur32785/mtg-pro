import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/nfc/write_nfc/controller/write_nfc_controller.dart';

import '../../../core/values/k_images.dart';

class WriteNfcCardScreen extends GetView<WriteNfcController> {
  const WriteNfcCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ashColor,
        appBar: AppBar(
          backgroundColor: ashColor,
          centerTitle: true,
          title: const Text(
            "Nfc Card Preparing",
            style: TextStyle(color: Colors.black87),
          ),
          foregroundColor: Colors.black87,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(
              width: double.infinity,
            ),
            const Image(
              image: AssetImage(KImages.logo),
              height: 150,
            ),
            // const Expanded(
            //   child: Image(
            //     image: AssetImage("assets/images/nfc_image.jpg"),
            //     height: 60,
            //   ),
            // ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                // boxShadow: [
                //   BoxShadow(
                //     blurRadius: 10,
                //     color: Colors.grey.withOpacity(2),
                //     offset: const Offset(
                //       0,10
                //     )
                //   )
                // ]
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Ready To Scan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  Image.asset(
                    "assets/images/nfc_new2.png",
                    // fit: fit,
                    height: 150,
                    width: 150,
                    // color: color,
                  ),

                  // SizedBox(
                  //   height: 170,
                  //   child: Stack(
                  //     alignment: Alignment.bottomCenter,
                  //     clipBehavior: Clip.antiAlias,
                  //     children: [
                  //       const Positioned(
                  //         bottom: -30,
                  //         child: Image(image: AssetImage("assets/images/smartphone.png"),height: 150,color: Colors.blue,),
                  //       ),
                  //       Positioned(
                  //         bottom: 0,
                  //         child: Container(
                  //           height: 170,
                  //           width: 170,
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(color: Colors.blue,width: 8)
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() {
                    if (controller.stateStatus == WriteNfcStatus.waiting) {
                      return const Text(
                        "Hold your PRO device \nNear your phones NFC reader",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      );
                    } else if (controller.stateStatus ==
                        WriteNfcStatus.success) {
                      return Column(
                        children: const [
                          Text("Your Card is ready for use."),
                          SizedBox(
                            height: 16,
                          ),
                          // OutlinedButton(
                          //     onPressed: () {
                          //       Get.back();
                          //     },
                          //     child: const Text("Back"))
                        ],
                      );
                    } else if (controller.stateStatus ==
                        WriteNfcStatus.failed) {
                      return Column(
                        children: [
                          Text("${controller.errorMessage}"),
                          const SizedBox(
                            height: 16,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                controller.readAndWriteNfcTag(controller.url);
                              },
                              child: const Text("Retry"))
                        ],
                      );
                    }
                    return Column(
                      children: [
                        const Text("Waiting for instruction..."),
                        const SizedBox(
                          height: 16,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              controller.readAndWriteNfcTag(controller.url);
                            },
                            child: const Text("Retry"))
                      ],
                    );
                  }),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Cancel")),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
