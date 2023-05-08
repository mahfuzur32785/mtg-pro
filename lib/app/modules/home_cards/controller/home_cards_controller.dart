import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mtgpro/app/core/utils/helpers.dart';
import 'package:mtgpro/app/modules/home_cards/model/card_model.dart';
import 'package:mtgpro/app/modules/login/login_controller.dart';
import 'package:mtgpro/app/routes/routes.dart';

import '../../../data/error/failure.dart';
import '../../login/controller/auth_repository.dart';
import '../../login/model/user_prfile_model.dart';
import '../model/social_link_model.dart';
import 'card_list_repository.dart';

class HomeCardsController extends GetxController {
  final LoginController _loginController;
  final AuthRepository _authRepository;
  final CardListRepository _cardListRepository;
  HomeCardsController(this._loginController, this._cardListRepository,this._authRepository);
  var isLoading = false.obs;

  var cardList = [].obs;
  var liveCard = 0.obs;

  UserProfileModel? _userInfo;
  UserProfileModel? get userInfo => _userInfo ?? _loginController.userInfo!.user;
  set user(UserProfileModel userData) => _userInfo = userData;

  List<SocialLinkModel> socialLinks = [];
  List<SocialLinksCategory> socialLinkCategories = [];

  @override
  void onInit() {
    super.onInit();
    Future.microtask(() {
      getCards();
      getOnlyUserData();
      getSocialLinks();
    });
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getCards({bool isLoad = true}) async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      Helper.toastMsg("Please Login First!");
      return;
    }

    isLoading.value = isLoad;

    final token = _loginController.userInfo!.accessToken;
    final result = await _cardListRepository.getCards(token);

    result.fold((error) {
      isLoading.value = false;
      if (error.statusCode == 401) {
        Helper.toastMsg("Your Session is out. Please Login!");
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.offAllNamed(Routes.login);
        });
      } else {
        Helper.toastMsg(error.message);
      }
    }, (data) {
      isLoading.value = false;
      cardList.value = data;
      setLiveCard(data);
    });
  }

  void setLiveCard(List<CardModel> cards){
    // CardModel cardModel = cards.singleWhere((element) => element.status == 1,orElse: () {
    //   makeLiveCard(cards.first.id);
    //   return cards.first;
    // });
    CardModel cardModel = cards.singleWhere((element) => element.isLiveCard);
    liveCard.value = cardModel.id;
  }

  void changeLiveCard(int cardId){
    liveCard.value = cardId;
  }

  Future<Either<Failure, String>> makeLiveCard(int cardId) async {
    if (_loginController.userInfo == null) {
      return left(const ServerFailure("Please login first", 1000));
    }
    final result = await _cardListRepository.makeLiveCard(_loginController.userInfo!.accessToken,cardId);
    return result;
  }

  void getSocialLinks() async {
    _cardListRepository.checkSocialLinks().fold((l) async {
      //...... From api ......
      final result = await _cardListRepository.getSocialLink();
      result.fold((l) {

      }, (data) {
        socialLinks = data;
        separateSocialLinks(socialLinks);
      });

    }, (r) {
      final result = _cardListRepository.getCachedSocialLinks();
      result.fold((l) {

      }, (data) {
        socialLinks = data;
        separateSocialLinks(socialLinks);
      });
    });
  }

  void getOnlyUserData() async {
    if (_loginController.userInfo == null || _loginController.userInfo?.accessToken == null) {
      return;
    }
    final token = _loginController.userInfo!.accessToken;
    final result = await _authRepository.getOnlyUserData(token);

    result.fold((error) {
      _userInfo = _loginController.userInfo!.user;
    }, (data) {
      _userInfo = data;
    });
  }
  
  void separateSocialLinks(List<SocialLinkModel> links){
    List<String> titles = links.map((e) => e.iconGroup).toSet().toList();
    print(titles.length);
    for(int i = 0; i < titles.length; i++){
      List<SocialLinkModel> list = links.where((element) => element.iconGroup == titles[i]).toList();
      socialLinkCategories.add(SocialLinksCategory(titles[i], list));
    }
    print(socialLinkCategories.length);
  }

}