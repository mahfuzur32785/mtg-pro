import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

class ScannerController extends GetxController {
  final LoginController _loginController;
  ScannerController(this._loginController);

  var isLoading = false.obs;

  Future<String?> scanQrCode() async {
    String qrCodeRes;
    try {
      qrCodeRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (qrCodeRes.isNotEmpty && qrCodeRes != '-1') {
        return qrCodeRes;
      } else {
        Get.snackbar('QR Result', 'QR Code not found!');
      }
    } on PlatformException {
      qrCodeRes = 'Failed to get platform version.';
    }
    return null;
  }

  //........... text recognizer ..........
  // InputImage? inputImage;
  TextRecognizer textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  void scanTextRecognizer(int type) async {
    if (type == 1) {
      await Utils.captureImage().then((value) async {
        if (value != null) {
          final InputImage inputImage = InputImage.fromFilePath(value);
          Utils.loadingDialog(Get.context!);
          final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
          Utils.closeDialog(Get.context!);
          Get.toNamed(Routes.vcardToCrmScreen,arguments: recognizedText);
          // print("..................${recognizedText.blocks}.............");
          // print("...............................");
          // for(TextBlock textBlock in recognizedText.blocks){
          //   if (GetUtils.isEmail(textBlock.text)) {
          //     print("xxxxxxxxxx email ${textBlock.text} xxxxxxxxxxx");
          //   }
          //   if (GetUtils.isPhoneNumber(textBlock.text)) {
          //     print("xxxxxxxxxx number ${textBlock.text} xxxxxxxxxxx");
          //   }
          //   if (Utils.isUsername(textBlock.text)) {
          //     print("xxxxxxxxxx name ${textBlock.text} xxxxxxxxxxx");
          //   }
          //   print(textBlock.text);
          // }
          // print("...............................");
        }
      });
    } else {
      await Utils.pickSingleImage().then((value) async {
        if (value != null) {
          final InputImage inputImage = InputImage.fromFilePath(value);
          Utils.loadingDialog(Get.context!);
          final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
          Utils.closeDialog(Get.context!);
          Get.toNamed(Routes.vcardToCrmScreen,arguments: recognizedText);
        }
      });
    }

    // await Utils.pickSingleImage().then((value) async {

  }
}
