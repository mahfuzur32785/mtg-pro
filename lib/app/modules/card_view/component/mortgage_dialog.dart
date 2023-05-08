import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/card_view/controller/card_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/utils/constants.dart';
import '../../../core/values/strings.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../model/card_preview_model.dart';

class MortgageDialog {
  static openMortgageCalculator(
    context,
    CardPreviewModel cardPreviewModel,
  ) {
    final CardViewController controller = Get.find();

    WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // changeLoading(progress) ;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(mortgageUrl));

    final formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var jobTitleController = TextEditingController();
    var companyController = TextEditingController();
    var noteController = TextEditingController();

    bool isLoading = false;

    return showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 3,
        // isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        builder: (context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              minChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return StatefulBuilder(builder: (context, setState) {
                  return CustomScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(
                                    cardPreviewModel.profilePicUrl),
                                height: 80,
                                width: 80,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: Text(
                                "Welcome to ${cardPreviewModel.title}'s mortgage.",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                            ],
                          )),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.5,
                            minHeight: MediaQuery.of(context).size.height * 0.4,
                          ),
                          child: WebViewWidget(
                            controller: webViewController,
                            gestureRecognizers: Utils.getMapGestureRecognizer(),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        sliver: SliverToBoxAdapter(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                CustomEditText().boxEditText(
                                    nameController,
                                    '',
                                    "Name",
                                    Helper.validationAverage,
                                    TextInputType.text,
                                    Colors.white),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomEditText().boxEditText(
                                    emailController,
                                    '',
                                    "Email",
                                    Helper.validationEmail,
                                    TextInputType.emailAddress,
                                    Colors.white),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomEditText().boxEditText(
                                    phoneController,
                                    '',
                                    "Phone Number",
                                    Helper.validationAverage,
                                    TextInputType.number,
                                    Colors.white),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomEditText().boxEditText(
                                    jobTitleController,
                                    '',
                                    "Job Title",
                                    Helper.validationAverage,
                                    TextInputType.text,
                                    Colors.white),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomEditText().boxEditText(
                                    companyController,
                                    '',
                                    "Company Name",
                                    Helper.validationAverage,
                                    TextInputType.text,
                                    Colors.white,
                                    maxLines: 1),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomEditText().boxEditText(
                                    noteController,
                                    '',
                                    "Questions,Comments or Important Details",
                                    Helper.validationAverage,
                                    TextInputType.text,
                                    Colors.white,
                                    maxLines: 4),
                                const SizedBox(
                                  height: 16,
                                ),
                                LayoutBuilder(builder: (context, constraints) {
                                  if (isLoading == true) {
                                    return SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.mainColor,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    );
                                  }
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.mainColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 10),
                                        foregroundColor: Colors.white),
                                    onPressed: () async {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      Utils.closeKeyBoard(context);
                                      final body = <String, dynamic>{};
                                      body.addAll(
                                          {"name": nameController.text.trim()});
                                      body.addAll({
                                        "email": emailController.text.trim()
                                      });
                                      body.addAll({
                                        "phone": phoneController.text.trim()
                                      });
                                      body.addAll({
                                        "job_title":
                                            jobTitleController.text.trim()
                                      });
                                      body.addAll({
                                        "company_name":
                                            companyController.text.trim()
                                      });
                                      body.addAll({
                                        "message": noteController.text.trim()
                                      });
                                      body.addAll({
                                        "card_id": '${cardPreviewModel.id}'
                                      });

                                      setState(() {
                                        isLoading = true;
                                      });

                                      final result =
                                          await controller.connectWithMe(body);

                                      result.fold((error) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Helper.toastMsg(error.message);
                                      }, (data) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Helper.toastMsg(data);

                                        emailController.text = '';
                                        nameController.text = '';
                                        phoneController.text = '';
                                        jobTitleController.text = '';
                                        companyController.text = '';
                                        noteController.text = '';
                                      });
                                    },
                                    child: const Text("Send Message"),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 300,
                        ),
                      ),
                    ],
                  );
                });
              });
        });
  }
}
