import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/data/enums/state_status.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/global_widgets/page_loader.dart';
import 'package:mtgpro/app/modules/crm/view_connection/controller/view_connection_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../global_widgets/custom_image.dart';
import '../../../routes/routes.dart';

class ViewConnectionScreen extends GetView<ViewConnectionController> {
  const ViewConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ('${controller.argumentData[1]}'),
          style: const TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            icon: const FaIcon(
              FontAwesomeIcons.ellipsisVertical,
              size: 20,
              color: Colors.black54,
            ),
            onSelected: (value) {
              if (value == 0) {
                Get.toNamed(Routes.editConnectionScreen, arguments: [
                  controller.crmDetailsModel!.id,
                  controller.crmDetailsModel?.name,
                  controller.crmDetailsModel?.email,
                  controller.crmDetailsModel?.phone,
                  controller.crmDetailsModel?.title,
                  controller.crmDetailsModel?.companyName,
                  controller.crmDetailsModel?.message,
                  controller.crmDetailsModel?.profileImageUrl,
                ])?.then((result) {
                  if (result[0]["backValue"] == true) {
                    print("Result is coming...${result[0]["backValue"]}");
                    controller.getCrmDetails(controller.crmDetailsModel!.id);
                  }
                });
              }
              if (value == 1) {
                saveAsContact(context, controller.crmDetailsModel?.phone,
                    controller.crmDetailsModel?.name);
              }
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 0,
                onTap: () {},
                child: Row(
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.penToSquare,
                      size: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text("Edit"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                onTap: () {},
                child: Row(
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.download,
                      size: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text("Save As Contact"),
                  ],
                ),
              ),
              /*PopupMenuItem(
                value: 2,
                onTap: () {},
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.envelope,size: 20,),
                    SizedBox(
                      width: 16,
                    ),
                    Text("Email Lead"),
                  ],
                ),
              ),*/
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.stateStatus == StateStatus.LOADING ||
            controller.stateStatus == StateStatus.INITIAL) {
          return const PageLoader();
        }
        if (controller.stateStatus == StateStatus.FAILURE) {
          return Text("${controller.errorText}");
        }
        return CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            //.......... P R O F I L E ............
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth(context) * 0.4,
                      height: screenWidth(context) * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white,
                              width: 4,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 0)),
                          ]),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: screenWidth(context) * 0.4,
                            height: screenWidth(context) * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                  strokeAlign: BorderSide.strokeAlignOutside),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CustomImage(
                                path: controller.crmDetailsModel!.profileImageUrl,
                                fit: BoxFit.cover,
                              ),
                              // child: LayoutBuilder(
                              //     builder: (context,constraints) {
                              //       return Image.asset("assets/images/arif.jpg",fit: BoxFit.cover);
                              //     }
                              // )
                            ),
                          ),
                          /*Positioned(
                            bottom: 0,
                            child: Container(
                              width: screenWidth(context) * 0.1,
                              height: screenWidth(context) * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignOutside),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 16,
                                        offset: const Offset(0, 0)),
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 16,
                                        offset: const Offset(0, 0)),
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const CustomImage(
                                  path: "https://www.mtgpro.me/companyLogo/6412a0286ccd0.jpg",
                                  fit: BoxFit.cover,
                                ),
                                // child: LayoutBuilder(
                                //     builder: (context,constraints) {
                                //       return Image.asset("assets/images/arobil_logo.png",fit: BoxFit.cover);
                                //     }
                                // )
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${controller.crmDetailsModel!.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                      ),
                    ),
                    Text(
                      "${controller.crmDetailsModel!.title} at ${controller.crmDetailsModel!.title}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      controller.crmDetailsModel!.queryType == 2
                          ? "${controller.crmDetailsModel!.currentCity}, ${controller.crmDetailsModel!.currentStreet}"
                          : '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //.......... C O N T A C T  I N F O ............
            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 3,
                          offset: const Offset(-5, -5)),
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 3,
                          offset: const Offset(5, 5)),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "${controller.crmDetailsModel!.name}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(Utils.getTypeOfCrm(controller.crmDetailsModel!.queryType),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Visibility(
                      visible: controller.crmDetailsModel!.email != "",
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(text: "${controller.crmDetailsModel!.email}"));
                                  Helper.toastMsg("Copied");
                                  },
                                child: const Icon(
                                  Icons.copy,
                                  size: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${controller.crmDetailsModel!.email}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.crmDetailsModel!.phone != "",
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Number",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(text: "${controller.crmDetailsModel!.phone}"));
                                  Helper.toastMsg("Copied");
                                },
                                child: const Icon(
                                  Icons.copy,
                                  size: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${controller.crmDetailsModel!.phone}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.crmDetailsModel!.title != "",
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Job Title",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${controller.crmDetailsModel!.title}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.crmDetailsModel!.companyName != "",
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Company",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            // SizedBox(width: 8,),
                            const Spacer(),
                            Text(
                              "${controller.crmDetailsModel!.companyName}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //.......... A D D R E S S ............
            SliverLayoutBuilder(
              builder: (p0, p1) {
                if (controller.crmDetailsModel!.queryType == 2) {
                  return SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 3,
                                offset: const Offset(-5, -5)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 3,
                                offset: const Offset(5, 5)),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Address",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.applicantName != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Applicant name",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.applicantName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.socialSecurityNumber != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Social security number",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.socialSecurityNumber,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.dateOfBirth != "" && controller.crmDetailsModel!.dateOfBirth != "0000-00-00",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Date of birth",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.dateOfBirth,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.currentStreet != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current Street",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.currentStreet,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.currentCity != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current City",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.currentCity,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.currentState != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current State",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.currentState,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.currentDate != "" && controller.crmDetailsModel!.currentDate != "0000-00-00",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current Date",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.currentDate,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.priorAddress != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Prior Address ",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.priorAddress,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.priorCity != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Prior City ",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.priorCity,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (controller.crmDetailsModel!.queryType == 3) {
                  return SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 3,
                                offset: const Offset(-5, -5)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 3,
                                offset: const Offset(5, 5)),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Finance Information",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.purpose != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Purpose of Loan",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.purpose,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.price != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Price",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.price,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.propertyType != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Type of Property",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.propertyType,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.location != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Location",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.location,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.occupation != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Occupation",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.occupation,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.currentEmployer != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current Employer",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.currentEmployer,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.annualIncome != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Annual Income",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.annualIncome,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.crmDetailsModel!.creditScore != "",
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Credit Score",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Spacer(),
                                  Text(
                                    controller.crmDetailsModel!.creditScore,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              },
            ),
          ],
        );
      }),
    );
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
}
