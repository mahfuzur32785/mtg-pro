import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/scan/scan_controller.dart';
class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanController>(
      init: ScanController(),
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text("Scan",style: TextStyle(color: AppColors.mainColor),),
                  backgroundColor: Colors.white,
                  systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark,statusBarColor: Colors.white),
                  elevation: 0,
                  titleSpacing: 16,
                  pinned: true,
                  bottom: PreferredSize(
                    preferredSize: const Size(double.infinity,30),
                    child: Container(
                      color: AppColors.mainColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                      child: Row(
                        children: [
                          const Text("1 card scan remaining",style: TextStyle(color: Colors.white),),
                          const Spacer(),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (){},
                              child: const Text("NEED MORE?",style: TextStyle(color: Colors.white),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    // IconButton(
                    //   onPressed: (){},
                    //   icon: Icon(Icons.add,color: AppColors.mainColor),
                    // )
                  ],
                ),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 90,
                        child: Stack(
                          children: [
                            DottedBorder(
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.butt,
                              dashPattern: [
                                3,4
                              ],
                              strokeWidth: 1,
                              radius: Radius.circular(6),
                              color: Colors.black45,
                              child: SizedBox(
                                height: 60,
                                width: 70,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.butt,
                                dashPattern: const [
                                  3,4
                                ],
                                strokeWidth: 1,
                                radius: const Radius.circular(6),
                                color: Colors.black45,
                                child: const SizedBox(
                                  height: 60,
                                  width: 70,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                        child: const Text("Take a picture of a paper business card and receive an accurat, human verified contact within 24 hours.",textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                    child: FloatingActionButton.extended(
                      backgroundColor: AppColors.mainColor,
                      shape: const StadiumBorder(),
                      // extendedPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      onPressed: (){},
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text("Scan"),
                    ),
                  ),
                )
              ],
            ),
            floatHeaderSlivers: false,
          ),
          // child: CustomScrollView(
          //   scrollDirection: Axis.vertical,
          //   slivers: [
          //     SliverAppBar(
          //       title: Text("Scan",style: TextStyle(color: AppColors.mainColor),),
          //       backgroundColor: Colors.white,
          //       systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark,statusBarColor: Colors.white),
          //       elevation: 0,
          //       titleSpacing: 16,
          //       pinned: true,
          //       // leading: IconButton(
          //       //   onPressed: (){},
          //       //   icon: Icon(Icons.document_scanner,color: AppColors.mainColor),
          //       // ),
          //       actions: [
          //         // IconButton(
          //         //   onPressed: (){},
          //         //   icon: Icon(Icons.add,color: AppColors.mainColor),
          //         // )
          //       ],
          //     ),
          //     const SliverToBoxAdapter(
          //       child: Divider(
          //         height: 1,
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
