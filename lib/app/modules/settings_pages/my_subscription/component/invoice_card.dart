import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/data/remote_urls.dart';
import 'package:mtgpro/app/global_widgets/download_method.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/controller/subscription_controller.dart';
import 'package:mtgpro/app/modules/settings_pages/my_subscription/model/invoice_model.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/helpers.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../my_order/component/save_pdf_file.dart';

class InvoiceCard extends StatefulWidget {
  const InvoiceCard({Key? key, required this.index, required this.invoiceModel})
      : super(key: key);
  final int index;
  final InvoiceModel invoiceModel;

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  bool isTap = false;
  void _onTapDown(TapDownDetails details) {
    setState(() {
      isTap = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        isTap = false;
      });
    });
  }

  final SubscriptionController subscriptionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.invoiceModel.invoiceNumber,
                style: GoogleFonts.merriweatherSans(),
              ),
              Text(
                "\$${widget.invoiceModel.transactionAmount}.00",
                style: GoogleFonts.merriweatherSans(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  Utils.formatDateSpecial(widget.invoiceModel.transactionDate)),
              GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTap: () async {
                    _createPDF(
                        filename: widget.invoiceModel.invoiceNumber,
                        context: context);

                    // Helper.toastMsg("Coming soon...");
                    // return;
                    // final result = await subscriptionController.downloadFile("https://javapapers.com/wp-content/uploads/2014/08/Android-Studio-Shortcuts-You-Need-the-Most.pdf", '${widget.invoiceModel.userId}${widget.invoiceModel.invoiceNumber}',".pdf");
                    // final result = await subscriptionController.downloadFile("${RemoteUrls.baseUrl}user/invoice/download/${widget.invoiceModel.invoiceNumber}", '${widget.invoiceModel.userId}${widget.invoiceModel.invoiceNumber}',".pdf");
                    // result.fold((error) {
                    //   Helper.toastMsg(error.message);
                    // }, (path) {
                    //   Helper.toastMsg("Invoice Successfully download");
                    // });
                    // goDownload(downloadUrl: "${RemoteUrls.baseUrl}user/invoice/download/${widget.invoiceModel.invoiceNumber}",fileName: "${widget.invoiceModel.userId}_${widget.invoiceModel.invoiceNumber}",context: context);
                    // return;
                    // Utils.appLaunchUrl('${RemoteUrls.rootUrl}user/invoice/download/${widget.invoiceModel.invoiceNumber}');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.download,
                          size: 24,
                          color: isTap ? Colors.black87 : Colors.blue),
                    ],
                  ))
            ],
          ),
          Text(widget.invoiceModel.description),
          const Divider(
            height: 30,
          )
        ],
      ),
    );
  }

  final pdf = pw.Document();
  int apiLevel = 0;

  Future<void> _createPDF({filename, context}) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    apiLevel = androidInfo.version.sdkInt;
    PermissionStatus storagePermission;
    print(apiLevel);

    if (apiLevel >= 33) {
      storagePermission = await Permission.mediaLibrary.request();
    } else {
      storagePermission = await Permission.storage.request();
    }
    if (storagePermission == PermissionStatus.granted) {
      try {
        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return [
                pw.Row(
                  children: [
                    pw.SizedBox(width: 1 * PdfPageFormat.mm),
                    pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'MTGPRO.ME',
                        ),
                        pw.Text(
                          'Non-QM Doc LLC',
                        ),
                        pw.Text(
                          '1603 Capitol Ave. Suite 310',
                        ),
                        pw.Text(
                          'Cheyenne, Wyoming',
                        ),
                        pw.Text(
                          'USA, 82001',
                        ),
                        pw.Text(
                          'Info@MTGPro.me',
                        ),
                        pw.Text(
                          '0',
                        ),
                        pw.Text(
                          'INVOICE NO : - ${widget.invoiceModel.invoiceNumber}',
                        ),
                      ],
                    ),
                    pw.Spacer(),
                    pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(subscriptionController.userInfo!.user.name),
                        pw.Text(
                          subscriptionController.userInfo!.user.billingCity,
                        ),
                        pw.Text(
                          subscriptionController.userInfo!.user.billingState,
                        ),
                        pw.Text(
                          subscriptionController.userInfo!.user.billingCountry,
                        ),
                        pw.Text(
                          subscriptionController.userInfo!.user.email,
                        ),
                        pw.Text(
                          '+880',
                        ),
                        pw.Text(
                          'INVOICE DATE : ${widget.invoiceModel.transactionDate}',
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10 * PdfPageFormat.mm),

                //Row 1
                pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Description",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold)))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text("Amount",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold)))),
                ]),
                pw.Divider(color: PdfColors.grey),

                //Row 2
                pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child:
                              pw.Text("${widget.invoiceModel.description}"))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                              "\$${widget.invoiceModel.transactionAmount}.00"))),
                ]),
                pw.Divider(color: PdfColors.grey),

                //Row 3
                pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Subtotal"))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                              "\$${widget.invoiceModel.transactionAmount}.00"))),
                ]),
                pw.Divider(color: PdfColors.grey),

                //Row 4
                pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Tax Amount"))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text("\$0.00"))),
                ]),
                pw.Divider(color: PdfColors.grey),

                //Row 5
                pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Total"))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                              "\$${widget.invoiceModel.transactionAmount}.00"))),
                ]),
                pw.Divider(color: PdfColors.grey),
              ];
            },
          ),
        );

        final bytes = await pdf.save();
        SaveFile.saveAndLaunchFile(bytes, '$filename.pdf', apiLevel, context);
      } catch (e) {
        if (kDebugMode) {
          print("Error $e ");
        }
        apiLevel >= 33
            ? ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Already saved in your device"),
                ),
              )
            : ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Already saved in your device"),
                  action: SnackBarAction(
                    label: "Open",
                    onPressed: () {
                      OpenFile.open(
                          '/storage/emulated/0/Download/$filename.pdf');
                    },
                  ),
                ),
              );
        //   print("Saved already");
      }
    } else if (storagePermission.isDenied) {
      Helper.toastMsg("Required Storage Permission");
      openAppSettings();
    } else if (storagePermission.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
