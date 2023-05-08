import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
enum WriteNfcStatus {initial, waiting, success, failed}
class WriteNfcController extends GetxController {
  final _stateStatusRx = Rx<WriteNfcStatus>(WriteNfcStatus.initial);
  WriteNfcStatus get stateStatus => _stateStatusRx.value;

  var url = '';
  var errorMessage = ''.obs;

  @override
  void onInit() {
    var arguments = Get.arguments;
    url = arguments;
    readAndWriteNfcTag(arguments);
    super.onInit();
  }

  void readAndWriteNfcTag(url) async {
    _stateStatusRx.value = WriteNfcStatus.waiting;
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (kDebugMode) {
      print(isAvailable);
    }
    if (isAvailable) {
      // Start Session
      // NfcManager.instance.startSession(
      //   alertMessage: "Please close to NFC Card",
      //   onDiscovered: (NfcTag tag) async {
      //     if (kDebugMode) {
      //       print(tag.handle);
      //       print(tag.data);
      //       print(tag.obs);
      //       print(tag.hashCode);
      //     }
      //     final ndef = Ndef.from(tag);
      //     final formatAble = NdefFormatable.from(tag);
      //     final message = NdefMessage([NdefRecord.createText(url)]);
      //     if (ndef != null) {
      //       print("Writing as NDEF");
      //       Get.snackbar("Message","Writing as NDEF for both devices");
      //       await ndef.write(message);
      //     } else if (formatAble != null) {
      //       print("Writing as format able NDEF");
      //       Get.snackbar("Message","Writing as format able NDEF for only Android");
      //       await formatAble.format(message);
      //     }
      //     Future.delayed(const Duration(seconds: 2)).then((value) async {
      //       _stateStatusRx.value = WriteNfcStatus.success;
      //       Get.snackbar("Message", "Your Card is ready for use.");
      //       await NfcManager.instance.stopSession();
      //     });
      //   },
      //   onError: (error) async {
      //     printError();
      //     _stateStatusRx.value = WriteNfcStatus.failed;
      //     errorMessage.value = error.message;
      //   },
      // );

      //////////////////////////////

      if (Platform.isAndroid) {
        NfcManager.instance.startSession(
          alertMessage: "Please close to NFC Card",
          onDiscovered: (NfcTag tag) async {
            if (kDebugMode) {
              print(tag.handle);
              print(tag.data);
              print(tag.obs);
              print(tag.hashCode);
            }
            final ndef = Ndef.from(tag);
            final NfcA? nfcA = NfcA.from(tag);
            final formatAble = NdefFormatable.from(tag);
            final message = NdefMessage([NdefRecord.createText(url)]);
            if (ndef != null) {
              print("Writing as NDEF");
              Get.snackbar("Message","Writing as NDEF for both devices");
              await ndef.write(message);
            } else if (nfcA != null) {
              // Connect to the tag
              // Write the data to the tag
              List<int> list = utf8.encode(url);
              Uint8List bytes = Uint8List.fromList(list);
              Uint8List writeCommand = Uint8List.fromList([
                0xA2, // Write command
                0x04, // Page address
                0x01, // Data
                0x02, // Data
                0x03, // Data
                0x04,
                ...utf8.encode(url),
              ]);
              await nfcA.transceive(data: writeCommand,);
              print("Writing as NFCA");
              Get.snackbar("Message","Writing as NFCA");
            } else if (formatAble != null) {
              await formatAble.format(message);
              print("Writing as format able NDEF");
              Get.snackbar("Message","Writing as format able NDEF for only Android");
            }
            Future.delayed(const Duration(seconds: 2)).then((value) async {
              _stateStatusRx.value = WriteNfcStatus.success;
              Get.snackbar("Message", "Your Card is ready for use.");
              await NfcManager.instance.stopSession();
            });
          },
          onError: (error) async {
            printError();
            _stateStatusRx.value = WriteNfcStatus.failed;
            errorMessage.value = error.message;
          },
        );
      } else if (Platform.isIOS) {
        NfcManager.instance.startSession(
          alertMessage: "Please close to NFC Card",
          onDiscovered: (NfcTag tag) async {
            if (kDebugMode) {
              print(tag.handle);
              print(tag.data);
              print(tag.obs);
              print(tag.hashCode);
            }
            final ndef = Ndef.from(tag);
            final message = NdefMessage([NdefRecord.createText(url)]);
            if (ndef != null) {
              print("Writing as NDEF");
              Get.snackbar("Message","Writing as NDEF for both devices");
              await ndef.write(message);
            } else {
              _writeDataToTagFelia(tag,url);
              print("Writing as NFCA");
              Get.snackbar("Message","Writing as NFCA");
            }
            Future.delayed(const Duration(seconds: 2)).then((value) async {
              _stateStatusRx.value = WriteNfcStatus.success;
              Get.snackbar("Message", "Your Card is ready for use.");
              await NfcManager.instance.stopSession();
            });
          },
          onError: (error) async {
            printError();
            _stateStatusRx.value = WriteNfcStatus.failed;
            errorMessage.value = error.message;
          },
        );
      }
      //////////////////////////////

      // Stop Session
      // NfcManager.instance.stopSession();
    } else {
      Get.snackbar("Error", "Please Start your mobile device NFC");
    }
  }

  void _writeDataToTagFelia(NfcTag tag, String data) async {
    try {
      NfcF? nfcF = NfcF.from(tag);
      // Send a command to write data to the tag
      List<int> command = [
        0xd6, // Write without encryption command
        0x8b, // Service code list order (SCLO)
        0x01, // Service code list order (SCLO)
        0x0f, // Number of blocks to write
      ];
      for (int i = 0; i < 15; i++) {
        // Calculate the block number
        int blockNumber = 0x80 | i;
        // Calculate the data to write to the block
        String blockData = data.substring(i * 16, (i + 1) * 16);
        List<int> dataBytes = utf8.encode(blockData);
        // Add the block number and data to the command
        command.addAll([blockNumber, ...dataBytes]);
      }
      // Send the command to the tag
      await nfcF?.transceive(data: Uint8List.fromList(command));
    } catch (e) {
      // Handle the error
    }
  }
  void _writeDataToTagNFCA(NfcTag tag, String data) async {
    try {
      NfcA? nfcA = NfcA.from(tag);
      List<int> command = [
        0xA2, // Write command
        0x04, // Block number to write
        ...utf8.encode(data), // Data to write
      ];
      await nfcA?.transceive(data: Uint8List.fromList(command));
    } catch (e) {
      // Handle the error
    }
  }

}

// <key>com.apple.developer.nfc.readersession.felica.systemcodes</key>
// <array>
// <string>0003</string>
// <string>04D1</string>
// <string>8008</string>
// <string>80DE</string>
// <string>865E</string>
// <string>8592</string>
// <string>8B5D</string>
// <string>8FC1</string>
// <string>FE00</string>
// <string>ISO18092</string>
// </array>
// <key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
// <array>
// <string>ISO7816</string>
// </array>