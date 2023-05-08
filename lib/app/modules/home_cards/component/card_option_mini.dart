import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants.dart';

class CardOptionMini {
  static optionMini(context){
    showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFFFFFFF),
        // elevation: 3,
        // isDismissible: true,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        useSafeArea: true,
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
        // ),
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: screenHeight(context) > 800 ? 0.26 : 0.3,
              maxChildSize: 0.3,
              minChildSize: 0.26,
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: CustomScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: (){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    child: Column(
                                      children: const [
                                        FaIcon(
                                            FontAwesomeIcons.penToSquare),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Edit")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: (){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    child: Column(
                                      children: const [
                                        FaIcon(FontAwesomeIcons.penToSquare),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Live")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: (){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    child: Column(
                                      children: const [
                                        FaIcon(FontAwesomeIcons.cameraRetro),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Preview")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: (){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    child: Column(
                                      children: const [
                                        FaIcon(FontAwesomeIcons.qrcode),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("QR Code")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: (){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    child: Column(
                                      children: const [
                                        FaIcon(FontAwesomeIcons.share),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Share")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: (){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    child: Column(
                                      children: const [
                                        FaIcon(FontAwesomeIcons.penToSquare),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Edit")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}