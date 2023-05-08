import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:csv/csv.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtgpro/app/core/utils/constants.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/global_widgets/custom_edittext.dart';
import 'package:mtgpro/app/global_widgets/download_method.dart';
import 'package:mtgpro/app/modules/crm/controller/crm_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/values/colors.dart';
import '../../core/values/k_images.dart';
import '../../data/enums/state_status.dart';
import '../../global_widgets/helper_text.dart';
import '../settings_pages/my_order/component/save_pdf_file.dart';

class CrmScreen extends GetView<CrmController> {
  CrmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CRM",
          style: TextStyle(color: AppColors.mainColor),
        ),backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon:
          Icon(Icons.arrow_back, color: AppColors.mainColor),
        ),
        actions: [
          SizedBox(
            height: 35,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.mainColor),
              onPressed: () {
                _createCsv(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.download,
                size: 20,
              ),
              label: const Text("Export"),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () => controller.onBackPressed(context),
        child: Obx(
          () => controller.stateStatus == StateStatus.LOADING
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Divider(
                        height: 1,
                      ),
                    ),

                    //SEARCH FIELD, DATE RANGE FIELD, SEARCH BUTTON
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CustomEditText().borderEditText(
                                  controller.searchController,
                                  '',
                                  "Search name, email, company",
                                  Helper.noValidation,
                                  TextInputType.text,
                                  Colors.white),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            PopupMenuButton(
                              color: Colors.white,
                              icon: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: ashColor),
                                    borderRadius: BorderRadius.circular(4)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Obx(
                                  () => Text(
                                      controller.dateRangeController.value),
                                ),
                              ),
                              onSelected: (value) {
                                controller.dateChange(value);
                                print(controller.dateRangeController.value);
                              },
                              itemBuilder: (context) => <PopupMenuEntry>[
                                PopupMenuItem(
                                  value: 0,
                                  onTap: () {},
                                  child: const Text("Today"),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  onTap: () {},
                                  child: const Text("Yesterday"),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  onTap: () {},
                                  child: const Text("Last 7 days"),
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  onTap: () {},
                                  child: const Text("Last 30 days"),
                                ),
                                PopupMenuItem(
                                  value: 4,
                                  onTap: () {},
                                  child: const Text("This Month"),
                                ),
                                PopupMenuItem(
                                  value: 5,
                                  onTap: () {},
                                  child: const Text("Last Month"),
                                ),
                                PopupMenuItem(
                                  value: 6,
                                  onTap: () {},
                                  child: const Text("Custom Range"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.mainColor,
                                    foregroundColor: Colors.white),
                                onPressed: () async {
                                  if (controller.searchController.text == "" && controller.dateRangeController.value == "YYYY/MM/DD") {
                                    Helper.toastMsg("Search Name,Email,Company Select Date");
                                    return;
                                  }
                                  controller.getCrmData(
                                    search: controller.searchController.text
                                        .toString()
                                        .trim(),
                                    dateRange: controller.dateRangeController.value == "YYYY/MM/DD"
                                        ? ''
                                        : controller.dateRangeController.value
                                            .toString(),
                                  );
                                },
                                child: const Text("Search"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //SELECT ALL OPTION
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: controller.isSelected.value ? 8 : 0),
                      sliver: SliverToBoxAdapter(
                        child: Visibility(
                          visible: controller.isSelected.value,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.mainColor,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: () {
                                  if (controller.crmList.any(
                                      (element) => element.isSelect == false)) {
                                    controller.selectAll(true);
                                  } else {
                                    controller.selectAll(false);
                                  }
                                },
                                icon: Icon(controller.crmList.every(
                                        (element) => element.isSelect == true)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank),
                                label: Text(controller.crmList.every(
                                        (element) => element.isSelect == true)
                                    ? "Unselect All"
                                    : "Select All"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //CARD LIST
                    controller.crmList.value.isNotEmpty
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    controller.changeSelect(true);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: controller.isSelected.value
                                            ? 0
                                            : 10,
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 6,
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              offset: const Offset(5, 5))
                                        ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Visibility(
                                              visible:
                                                  controller.isSelected.value,
                                              child: SizedBox(
                                                width: 30,
                                                child: Checkbox(
                                                  checkColor: AppColors.white,
                                                  activeColor:
                                                      AppColors.mainColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  value: controller
                                                      .crmList[index].isSelect,
                                                  onChanged: (value) {
                                                    print(value);
                                                    controller.selectOne(
                                                        value,
                                                        controller
                                                            .crmList[index].id);
                                                  },
                                                ),
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  controller.crmList[index]
                                                      .profileImageUrl),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(controller
                                                      .crmList[index].name),
                                                  Visibility(
                                                    visible: controller.crmList[index].email != '',
                                                    child: Text(controller
                                                        .crmList[index].email),
                                                  ),
                                                  Text("(${Utils.getTypeOfCrm(controller.crmList[index].queryType)})",style: const TextStyle(fontSize: 13,color: Colors.black54),),
                                                  // Text(
                                                  //   controller
                                                  //       .crmList[index].title,
                                                  //   style: const TextStyle(
                                                  //       color: Colors.black45),
                                                  // ),
                                                  Text(controller.formatter.format(DateTime.parse(controller.crmList[index].createdAt)),
                                                    style: const TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () async {
                                                            phoneCall(
                                                                controller
                                                                    .crmList[
                                                                        index]
                                                                    .phone,
                                                                context);
                                                          },
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        6.0),
                                                            child: Icon(
                                                              Icons
                                                                  .phone_outlined,
                                                              size: 22,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          )),
                                                      GestureDetector(
                                                          onTap: () {
                                                            sendEmail(
                                                                controller
                                                                    .crmList[
                                                                        index]
                                                                    .email,
                                                                context);
                                                          },
                                                          child: const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6.0),
                                                              child: Icon(
                                                                Icons.mail,
                                                                size: 22,
                                                                color: Colors
                                                                    .black87,
                                                              ))),
                                                      GestureDetector(
                                                          onTap: () {
                                                            sendSms(
                                                                controller
                                                                    .crmList[
                                                                        index]
                                                                    .phone,
                                                                context);
                                                          },
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        6.0),
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .commentDots,
                                                              size: 22,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuButton(
                                              color: Colors.white,
                                              icon: const FaIcon(
                                                FontAwesomeIcons
                                                    .ellipsisVertical,
                                                size: 20,
                                                color: Colors.black54,
                                              ),
                                              onSelected: (value) {
                                                if (value == 0) {
                                                  Get.toNamed(
                                                          Routes
                                                              .viewConnectionScreen,
                                                          arguments: [
                                                        controller
                                                            .crmList[index].id,
                                                        controller
                                                            .crmList[index].name
                                                      ])!
                                                      .then((value) {
                                                    controller.getCrmData();
                                                  });
                                                }
                                                if (value == 1) {
                                                  saveAsContact(
                                                      context,
                                                      controller
                                                          .crmList[index].phone,
                                                      controller
                                                          .crmList[index].name);
                                                }
                                                if (value == 2) {
                                                  showDialogForEmailSend(
                                                      context,
                                                      controller
                                                          .crmList[index].email,
                                                      controller
                                                          .crmList[index].id);
                                                }
                                              },
                                              itemBuilder: (context) =>
                                                  <PopupMenuEntry>[
                                                const PopupMenuItem(
                                                  value: 0,
                                                  child:
                                                      Text("View Connection"),
                                                ),
                                                const PopupMenuItem(
                                                  value: 1,
                                                  child:
                                                      Text("Save as Contact"),
                                                ),
                                                const PopupMenuItem(
                                                  value: 2,
                                                  child: Text("Send Mail"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: controller.crmList.length,
                            ),
                          )
                        : const SliverPadding(
                            padding: EdgeInsets.only(top: 50),
                            sliver: SliverToBoxAdapter(
                              child: Center(
                                child: Text(
                                  "No data found",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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
                        height: 50,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  phoneCall(phoneNumber, context) async {
    if (phoneNumber.toString().isNotEmpty) {
      final url = Uri.parse('tel:"$phoneNumber"');
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No phone number found')));
    }
  }

  sendEmail(email, context) async {
    if (email.toString().isNotEmpty) {
      final url = Uri.parse('mailto:$email');
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Email has found')));
    }
  }

  sendSms(phoneNumber, context) async {
    if (phoneNumber.toString().isNotEmpty) {
      final url = Uri.parse('sms:$phoneNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No phone number found')));
    }
  }

  saveAsContact(context, phoneNumber, name) async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    // print(permissionStatus);
    if (permissionStatus == PermissionStatus.granted) {
      print(permissionStatus);

      if (phoneNumber.toString().isNotEmpty) {
        var newPerson = Contact();
        // newPerson uses Contact Package
        newPerson.givenName = name.toString();
        newPerson.phones = [Item(label: "mobile", value: '$phoneNumber')];

        await ContactsService.addContact(newPerson);
        // var contacts = await ContactsService.getContacts();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Contact added successfully",
            style: TextStyle(color: Colors.white),
          ),
        ));
        print("Contact added successfully");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No phone number found",
            style: TextStyle(color: Colors.white),
          ),
        ));
      }

      // return contacts;
    }
    if (permissionStatus == PermissionStatus.denied) {
      print(permissionStatus);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Storage Permission is required',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      print(permissionStatus);
      openAppSettings();
    }
  }

  var formatter = DateFormat("hh:mm");
  Future<void> _createCsv(context) async {
    bool value = controller.crmList.any((element) => element.isSelect == true);
    if(!value) {
      Helper.toastMsg("Select At least One");
      return;
    };
    List<List<dynamic>> rows = <List<dynamic>>[];

    List<dynamic> row = [];
    row.add("Name");
    row.add("Email");
    row.add("Phone");
    row.add("Title");
    row.add("Profile Image");
    row.add("Company Name");
    rows.add(row);

    for (int i = 0; i < controller.crmList.length; i++) {
      //row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = [];
      if (controller.crmList[i].isSelect) {
        row.add(controller.crmList[i].name);
        row.add(controller.crmList[i].email);
        row.add(controller.crmList[i].phone);
        row.add(controller.crmList[i].title);
        row.add(controller.crmList[i].profileImage);
        row.add(controller.crmList[i].companyName);
        rows.add(row);
      }
    }

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    final apiLevel = androidInfo.version.sdkInt;
    PermissionStatus storagePermission;

    print(apiLevel);

    if (apiLevel >= 33) {
      storagePermission = await Permission.mediaLibrary.request();
    } else{
      storagePermission = await Permission.storage.request();
    }

    if (storagePermission == PermissionStatus.granted) {
      String csv = const ListToCsvConverter().convert(rows);

      int randomNum = Random().nextInt(100);
      String path = "/storage/emulated/0/Download/contact_info_$randomNum.xlsx";
      await File(path)
          .writeAsString(csv)
          .then((value) {
        Helper.toastMsg("Contact exported to download");
      });

      OpenFile.open(
        path,
        type: "application/vnd.ms-excel",
        uti: "com.microsoft.excel.xls",
      );

      // SaveFile.saveAndLaunchFile(bytes, 'output.pdf');
    } else if (storagePermission == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage Perpission is required")),
      );
    } else if (storagePermission == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    return;
  }

  showDialogForEmailSend(context, email, userId) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: AlertDialog(
            backgroundColor: Colors.white38,
            scrollable: true,
            content: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Recepients"),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: CustomEditText().boxEditText(
                        controller.recepientsController,
                        controller.recepientsController.text = email,
                        "Recepients",
                        Helper.validationEmail,
                        TextInputType.text,
                        ashColor,
                        readOnly: false),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Subject"),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: CustomEditText().boxEditText(
                        controller.subjectController,
                        '',
                        "Subject",
                        Helper.validationAverage,
                        TextInputType.text,
                        ashColor,
                        readOnly: false),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: HelperText().normalText("Message"),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: CustomEditText().boxEditText(
                        controller.messageController,
                        '',
                        "Message",
                        Helper.validationAverage,
                        TextInputType.text,
                        ashColor,
                        readOnly: false),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: Obx(
                      () => controller.isSendMessageBtnLoading.value
                          ? const Center(
                              child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator()))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mainColor,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.sendMessage(
                                    id: userId,
                                    recepients:
                                        controller.recepientsController.text,
                                    subject: controller.subjectController.text,
                                    message: controller.subjectController.text,
                                  );

                                  // String username = 'mahfuzurrahmanfaruk@gmail.com';
                                  // String password = '1111';
                                  //
                                  // final smtpServer = gmail(username, password);
                                  //
                                  // final message = Message()
                                  //   ..from = Address(username, 'Faruk')
                                  //   ..recipients.add(controller.recepientsController.text)
                                  //   ..subject = controller.subjectController.text
                                  //   ..text = controller.messageController.text;
                                  //
                                  // try {
                                  //   final sendReport = await send(message, smtpServer);
                                  //   print('Message sent: $sendReport');
                                  //   Get.back();
                                  // } on MailerException catch (e) {
                                  //   print('Message not sent.');
                                  //   for (var p in e.problems) {
                                  //     print('Problem: ${p.code}: ${p.msg}');
                                  //   }
                                  //   Get.back();
                                  // }
                                } else {
                                  print("Not valid");
                                }
                              },
                              child: const Text("Send Message")),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      controller.recepientsController.text = '';
      controller.subjectController.text = '';
      controller.messageController.text = '';
    });
  }
}
