import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:mtgpro/app/core/utils/extensions.dart';
import 'package:mtgpro/app/core/utils/utils.dart';
import 'package:mtgpro/app/data/enums/social_icon_type.dart';
import 'package:mtgpro/app/data/error/exception.dart';
import 'package:mtgpro/app/data/remote_urls.dart';
import 'package:mtgpro/app/modules/card_view/controller/care_preview_repository.dart';
import 'package:mtgpro/app/modules/card_view/model/card_preview_model.dart';
import 'package:mtgpro/app/modules/home_cards/model/social_link_model.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/enums/state_status.dart';
import '../../../data/error/failure.dart';

class CardViewController extends GetxController {
  final LoginController _loginController;
  final CardPreviewRepository _cardPreviewRepository;
  CardViewController(this._cardPreviewRepository, this._loginController);

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var isLoading = false.obs;

  CardPreviewModel? _cardPreviewModel;
  CardPreviewModel? get cardData => _cardPreviewModel;
  set cardPreviewModel(CardPreviewModel data) => _cardPreviewModel = data;
  String slug = '';

  var errorText = ''.obs;

  @override
  void onInit() {
    slug = Get.arguments;
    getCardView();
    super.onInit();
  }
  @override
  void onClose() {
    //.......
    super.onClose();
  }

  void closeDialog(){
    isLoading.value = false;
    update();
  }

  void getCardView() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }
    final token = _loginController.userInfo!.accessToken;
    String url = '${RemoteUrls.baseUrl}$slug';

    _stateStatusRx.value = StateStatus.LOADING;

    final result = await _cardPreviewRepository.getCard(url, token);
    result.fold((l) {
      errorText.value = l.message;
      _stateStatusRx.value = StateStatus.FAILURE;
      Helper.toastMsg(l.message);
    }, (data) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      _cardPreviewModel = data;
    });

  }

  // Future<String> downloadFile(String url, String fileName,) async {
  //   HttpClient httpClient = HttpClient();
  //   File file;
  //   String filePath = '';
  //   String myUrl = '';
  //
  //   try {
  //     myUrl = url;
  //     var request = await httpClient.getUrl(Uri.parse(myUrl));
  //     var response = await request.close();
  //     if(response.statusCode == 200) {
  //       var bytes = await consolidateHttpClientResponseBytes(response);
  //       filePath = 'sdcard/download/$fileName.jpg';
  //       file = File(filePath);
  //       await file.writeAsBytes(bytes);
  //     }
  //     else {
  //       filePath = 'Error code: ${response.statusCode}';
  //     }
  //   }
  //   catch(ex){
  //     filePath = 'Can not fetch url';
  //   }
  //   return filePath;
  // }
  //
  // Future<File> downloadFile2(String url, String filename) async {
  //   //instant view .........
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   //......... download........
  //   File file = File('sdcard/download/$filename.jpg');
  //
  //   await _cardPreviewRepository.isExist(filename).then((value) async {
  //     if (value) {
  //       var httpClient = HttpClient();
  //       var request = await httpClient.getUrl(Uri.parse(url));
  //       var response = await request.close();
  //       var bytes = await consolidateHttpClientResponseBytes(response);
  //       await file.writeAsBytes(bytes);
  //       return file;
  //     }
  //   });
  //
  //   return file;
  // }

  Future<Either<Failure, String>> downloadFile(String url, String fileName,) async {
    final result = await _cardPreviewRepository.downloadFile(url, fileName);
    return result;
  }

  void downloadContacts() async {
    Utils.appLaunchThis('${RemoteUrls.rootUrl}download/${cardData?.cardId}');
    return;
    final result = await _cardPreviewRepository.downloadContacts('${RemoteUrls.rootUrl}download/${cardData?.cardId}', '${cardData?.cardId}');
    result.fold((error) {
      Helper.toastMsg(error.message);
    }, (data) {
      Utils.appLaunchFile(data);
    });
  }

  Future<File> viewQrImage(String url, String filename) async {
    //instant view .........
    String dir = (await getApplicationDocumentsDirectory()).path;
    //......... download........
    File file = File('$dir/$filename');

    await _cardPreviewRepository.isExist(filename).then((value) async {
      if (!value) {
        var httpClient = HttpClient();
        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();
        var bytes = await consolidateHttpClientResponseBytes(response);
        await file.writeAsBytes(bytes);
        return file;
      }
    });

    return file;
  }
  
  void clickLink(SocialLinkModel socialLinkModel){
    IconType type = socialLinkModel.type.getIconType(socialLinkModel.type);
    print(type.toString());
    if (type == IconType.number) {
      Utils.appLaunchUrl('tel:${socialLinkModel.content}');
      return;
    } else if (type == IconType.mail) {
      Utils.appLaunchUrl('mailto:${socialLinkModel.content}');
      return;
    } else if (type == IconType.link) {
      Utils.appLaunchUrl(socialLinkModel.content);
      return;
    } else if (type == IconType.mobile) {
      Utils.appLaunchUrl('tel:${socialLinkModel.content}');
      return;
    } else if (type == IconType.address) {
      String url = "https://www.google.com/maps/place/${socialLinkModel.content}";
      // String queryWithLatLng = "https://www.google.com/maps/search/?api=1&query={latitude},{longitude}1";
      // String url = "https://www.google.com/maps/place/sector-13 park, uttara";
      Utils.appLaunchMap(url);
      return;
    }
    Utils.appLaunchUrl(socialLinkModel.content);
    return;
  }

  List<VCard> createVcf() {
    ///Create a new vCard
    List<VCard> cards = [];
    var vCard = VCard();

    ///Set properties
    vCard.firstName = 'fsd';
    vCard.middleName = 'fsdf';
    vCard.lastName = 'fsd';
    vCard.organization = 'fsdf';
    // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
    vCard.workPhone = '01860141948';
    vCard.birthday = DateTime.now();
    vCard.url = 'https://github.com/valerycolong';
    vCard.note = 'Notes on contact';

    /// Save to file
    vCard.saveToFile('contact.vcf');
    cards.add(vCard);

    /// Get as formatted string
    // print(vCard.getFormattedString());
    return cards;
  }


  void shareAllVCFCard(BuildContext context, {required vCard}) async {
    try {
      List<String> vcsCardPath = <String>[];
      int index = 0;
      for (final card in vCard) {
        index++;
        var vCardAsString = card.getFormattedString();
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        var pathAsText = "$path/$index.txt";

        var contactAsFile = File(await getFilePath('contacts${index.toString()}'));
        contactAsFile.writeAsString(vCardAsString);

        var vcf = contactAsFile
            .renameSync(contactAsFile.path.replaceAll(".txt", ".vcf"));
        vcsCardPath.add(vcf.path);
      }

      // Share.shareFiles(vcsCardPath, text: 'Great picture');
      Utils.appLaunchUrl(vcsCardPath[0]);
    } catch (e) {
      print("Error Creating VCF File $e");
      return null;
    }
  }

  Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory =
    await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    // String filePath = '$appDocumentsPath/$fileName.txt'; // 3
    String filePath = 'sdcard/download/$fileName.txt'; // 3

    return filePath;
  }

  Future<Either<Failure, String>> connectWithMe(Map<String, dynamic> body,) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      throw const UnauthorisedException("Unauthorized User", 401);
    }
    final token = _loginController.userInfo!.accessToken;

    final result = await _cardPreviewRepository.connectWithMe(body,token);
    return result;
  }

  Future<Either<Failure, String>> postCreditAuthorization(Map<String, dynamic> body,) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      throw const UnauthorisedException("Unauthorized User", 401);
    }
    final token = _loginController.userInfo!.accessToken;

    final result = await _cardPreviewRepository.postCreditAuthorization(body,token);
    return result;
  }

  Future<Either<Failure, String>> postQuickApplication(Map<String, dynamic> body,) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      throw const UnauthorisedException("Unauthorized User", 401);
    }
    final token = _loginController.userInfo!.accessToken;

    final result = await _cardPreviewRepository.postQuickApplication(body,token);
    return result;
  }

  saveAsContact(context, phoneNumber, name,) async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    // print(permissionStatus);
    if (permissionStatus == PermissionStatus.granted) {
      print(permissionStatus);

      if (phoneNumber.toString().isNotEmpty) {
        var newPerson = Contact();
        // newPerson uses Contact Package
        newPerson.givenName = name.toString();
        newPerson.company = cardData?.companyName;
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
            'Contact Permission is required',
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