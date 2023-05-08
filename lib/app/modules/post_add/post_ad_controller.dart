import 'package:mtgpro/app/modules/post_add/pages/sizes_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostAdController extends GetxController with GetSingleTickerProviderStateMixin{
  var isLoading = false.obs;
  var pageController = PageController(
    initialPage: 0,
  );

  int pageIndex = 0;
  void changePage(int index){
    pageIndex = index;
    update();
  }

  @override
  void onInit() {
    sizes.add(demoSize);


    //............... animation ............
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      scale = 1 - animationController.value;
      update();

    });
    // const color = Colors.white;

    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //.............. Basic Info ....................
  int purpose = -1;
  void changePurpose(value){
    purpose = value;
    update();
  }
  List<String> purposeList = [
    "Sale",
    "Rent",
    "Roommate"
  ];

  int propertyType = -1;
  void changePropertyType(value){
    propertyType = value;
    update();
  }
  List<String> propertyTypeList = [
    "Flat",
    "Land",
    "Office Space",
    "Shop",
    "Industrial Space",
    "Garage",
    "Land Share",
  ];

  String city = "Select City";
  void changeCity(value){
    city = value;
    update();
  }
  List<String> cityList = [
    "Select City",
    "Dhaka",
    "Chattogram",
    "Rajshahi",
    "Khulna",
    "Barishal",
    "Rangpur",
    "Sylhet",
    "Mymensingh"
  ];

  String? houseNo;
  var houseNoController = TextEditingController();

  String? roadNo;
  var roadNoController = TextEditingController();
  String? fullAddress;
  var fullAddressController = TextEditingController();

  //.............. Size and pricing ....................
  int condition = -1;
  void changeCondition(value){
    condition = value;
    update();
  }
  List<String> conditionList = [
    "Ongoing",
    "Ready",
    "Almost Ready",
    "Used",
    "Upcoming"
  ];

  Sizes demoSize = Sizes(null, "Bed", "Bath", "Balcony",
      ["Bed", "1", "2","3","4","5","6","7"],
      ["Bath", "1", "2","3","4","5","6","7"],
      ["Balcony", "1", "2","3","4","5","6","7"]);
  List<Sizes> sizes = [];
  void addSize(){
    sizes.add(demoSize);
    update();
  }
  void removeSize(index){
    sizes.removeAt(index);
    update();
  }

  String? landArea;
  var landAreaController = TextEditingController();

  String? pricePerStf;
  var pricePerStfController = TextEditingController();

  String? othersCost;
  var othersCostController = TextEditingController();

  String? totalPrice;
  var totalPriceController = TextEditingController();

  var isFixedPrice = false.obs;
  var isHidePrice = false.obs;

  void changeFixedPrice(){
    isFixedPrice.toggle();
    update();
  }
  void changeHidePrice(){
    isHidePrice.toggle();
    update();
  }

 //.............. contacts info ....................
  List<String> contactList = [""];
  var contactController = TextEditingController();
  void addContact(){
    contactList.add("");
    update();
  }
  void removeContact(index){
    contactList.removeAt(index);
    update();
  }

  //............. Package Plan .................
  var generalListing = false.obs;
  var featuredListing = false.obs;
  var autoUpdateListing = false.obs;
  void changeGeneralListing(){
    generalListing.toggle();
    update();
  }
  void changeFeaturedListing(){
    featuredListing.toggle();
    update();
  }
  void changeAutoUpdateListing(){
    autoUpdateListing.toggle();
    update();
  }


  //....................... Animation .........................
  final int delayedAmount = 100;
  late double scale;
  late AnimationController animationController;
}