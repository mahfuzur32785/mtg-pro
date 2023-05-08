import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/core/values/k_images.dart';
import 'package:mtgpro/app/global_widgets/custom_image.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/component/save_pdf_file.dart';
import 'package:mtgpro/app/modules/settings_pages/my_order/model/order_model.dart';
import 'package:open_file_plus/open_file_plus.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key, required this.myOrderModel}) : super(key: key);
  final MyOrderModel myOrderModel;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImage(
                  path: widget.myOrderModel.paymentMethod == "Stripe"
                      ? KImages.stripeIcon
                      : KImages.paypalIcon),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                decoration: BoxDecoration(
                  color: widget.myOrderModel.paymentStatus
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  widget.myOrderModel.paymentStatus ? "paid" : "Unpaid",
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.myOrderModel.paymentStatus
                          ? Colors.green
                          : AppColors.mainColor),
                  // borderRadius: const BorderRadius.all(Radius.elliptical(100, 30)),
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: <Color>[
                  //     AppColors.mainColor.withOpacity(0.9),
                  //     AppColors.mainColor.withOpacity(0.6),
                  //   ]
                  // )
                ),
                child: Text(
                  Utils.orderStatus(widget.myOrderModel.status),
                  style: TextStyle(
                      color: widget.myOrderModel.paymentStatus
                          ? Colors.green
                          : AppColors.mainColor),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Price : \$${widget.myOrderModel.totalPrice}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text("Date : ${widget.myOrderModel.orderDate}"),
          Text("Qty : ${widget.myOrderModel.quantity}"),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              // Helper.toastMsg("Coming soon...");
              // return;
              _createPDF(
                  filename: widget.myOrderModel.orderNumber, context: context);
            },
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Row(
              children: [
                Icon(Icons.download,
                    size: 24, color: isTap ? Colors.black87 : Colors.blue),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  "Invoice",
                  style: TextStyle(
                      color: isTap ? Colors.black87 : Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final pdf = pw.Document();
  int apiLevel = 0;

  Future<void> _createPDF({filename, context}) async {
    final iconImage = (await rootBundle.load('assets/images/mtg_logo_full.png'))
        .buffer
        .asUint8List();

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
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(
                        pw.MemoryImage(iconImage),
                        height: 100,
                        width: 100,
                      ),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("MTGPRO.ME",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 18)),
                            pw.Text("USA",
                                style: const pw.TextStyle(fontSize: 15)),
                          ])
                    ]),

                pw.SizedBox(height: 10 * PdfPageFormat.mm),

                pw.Divider(color: PdfColors.grey, height: 5),

                pw.SizedBox(height: 10 * PdfPageFormat.mm),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 1 * PdfPageFormat.mm),
                    pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'INVOICE',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Invoice No. ${widget.myOrderModel.orderNumber}',
                          style: const pw.TextStyle(
                            color: PdfColors.grey700,
                          ),
                        ),
                        pw.Text(
                          'Date: ${widget.myOrderModel.createdAt}',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text(
                            'Status: ',
                            style: const pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            widget.myOrderModel.paymentStatus
                                ? "Success"
                                : "Pending",
                            style: pw.TextStyle(
                                color: PdfColors.green,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ])
                      ],
                    ),
                    pw.Spacer(),
                    pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('SOLD TO:'),
                        pw.Text(
                          'Modern Contact Solutions\nFor Today\'s Mortgage \nProfessional',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Non-QM Doc LLC',
                        ),
                        pw.Text(
                          'Info@MTGPro.me',
                        ),
                        pw.Text(
                          '1603 Capitol Ave. Suite 310',
                        ),
                        pw.Text(
                          'Wyoming',
                        ),
                        pw.Text(
                          '0',
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20 * PdfPageFormat.mm),

                //Header
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                      border: pw.Border(
                    top: pw.BorderSide(color: PdfColors.grey500, width: 2),
                    bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                  )),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text("Product")),
                        flex: 2),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text("Unit")),
                        flex: 1),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text("Quantity")),
                        flex: 2),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text("Amount")),
                        flex: 1),
                  ]),
                ),

                //ROW 1

                ...List.generate(widget.myOrderModel.orderDetails.length,
                    (orderIndex) {
                  return pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom:
                            pw.BorderSide(width: 1, color: PdfColors.grey300),
                        left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                        right:
                            pw.BorderSide(width: 1, color: PdfColors.grey300),
                      ),
                      color: PdfColors.grey200,
                    ),
                    child: pw.Row(children: [
                      pw.Expanded(
                          child: pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(widget
                                  .myOrderModel
                                  .orderDetails[orderIndex]
                                  .product
                                  .productName)),
                          flex: 5),
                      pw.Expanded(
                          child: pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                  "\$${widget.myOrderModel.orderDetails[orderIndex].product.unitPrice}.00")),
                          flex: 3),
                      pw.Expanded(
                          child: pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                  "${widget.myOrderModel.orderDetails[orderIndex].quantity}")),
                          flex: 3),
                      pw.Expanded(
                          child: pw.Container(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                  "\$${widget.myOrderModel.totalPrice}.00")),
                          flex: 3),
                    ]),
                  );
                }),
                //ROW 2
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    ),
                    color: PdfColors.white,
                  ),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('')),
                        flex: 5),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("Total",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                                "\$${widget.myOrderModel.totalPrice}.00",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        flex: 3),
                  ]),
                ),

                //ROW 3
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    ),
                    color: PdfColors.grey200,
                  ),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('')),
                        flex: 5),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("Discount")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                                "\$${widget.myOrderModel.discount}.00")),
                        flex: 3),
                  ]),
                ),

                //ROW 4
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    ),
                    color: PdfColors.white,
                  ),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('')),
                        flex: 5),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child:
                                pw.Text("VAT (${widget.myOrderModel.vat}%)")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text("\$0.00")),
                        flex: 3),
                  ]),
                ),

                //ROW 5
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    ),
                    color: PdfColors.grey200,
                  ),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('')),
                        flex: 5),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("Shipping Cost")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                                "\$${widget.myOrderModel.shippingCost}.00")),
                        flex: 3),
                  ]),
                ),

                //ROW 6
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    ),
                    color: PdfColors.white,
                  ),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('')),
                        flex: 5),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("Payment Fee:")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                                "\$${widget.myOrderModel.paymentFee}.00")),
                        flex: 3),
                  ]),
                ),

                //ROW 7
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    ),
                    color: PdfColors.grey200,
                  ),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Currency: USD')),
                        flex: 5),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("Grand Total:",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                                "\$${widget.myOrderModel.grandTotal}.00",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        flex: 3),
                  ]),
                ),

                //ROW 8
                pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      left: pw.BorderSide(width: 1, color: PdfColors.grey300),
                      right: pw.BorderSide(width: 1, color: PdfColors.grey300),
                    ),
                    color: PdfColors.white,
                  ),
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('Payment Method: Stripe')),
                        flex: 5),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("")),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("Payment",
                                style: const pw.TextStyle(
                                    color: PdfColors.green))),
                        flex: 3),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                                "\$${widget.myOrderModel.grandTotal}.00",
                                style: pw.TextStyle(
                                    color: PdfColors.green,
                                    fontWeight: pw.FontWeight.bold))),
                        flex: 3),
                  ]),
                ),
              ];
            },
          ),
        );

        final bytes = await pdf.save();

        SaveFile.saveAndLaunchFile(bytes, 'mtgpro_$filename.pdf', apiLevel, context);

      } catch (e) {
        if (kDebugMode) {
          print("Error $e ");
        }
       apiLevel >= 33 ? ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Already saved in your device location"),
          ),
        ):ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: const Text("Already saved in your device location"),
           action: SnackBarAction(
             label: "Open",
             onPressed: () {
               OpenFile.open('/storage/emulated/0/Download/mtgpro_$filename.pdf');
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
      await openAppSettings();
      // _createPDF();
    }
    // else {
    //   print("xxxxxxxxxxxxxxxxxxxxx general xxxxxxxxxxxxxxxxxxxxxxxxxx");
    //   Map<Permission, PermissionStatus> statuses = await [
    //     Permission.storage,
    //   ].request();
    //   Future.delayed(const Duration(seconds: 1)).then((value) => _createPDF());
    // }
  }
}
