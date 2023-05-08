// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:mtgpro/app/core/utils/helpers.dart';
// import 'package:mtgpro/app/core/values/colors.dart';
// import 'package:mtgpro/app/data/models/social_media_model.dart';
// import 'package:get/get.dart';
// import 'package:mtgpro/app/modules/card_edit/controller/card_edit_controller.dart';
//
// import '../../../core/utils/constants.dart';
// import '../../../core/utils/utils.dart';
// import '../../../data/dummy_data.dart';
// import '../../../global_widgets/custom_edittext.dart';
// import '../../../global_widgets/helper_text.dart';
//
// class SocialDialog {
//   void chooseSocialLink(context){
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 3,
//         // isDismissible: true,
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
//         ),
//         builder: (context){
//           return DraggableScrollableSheet(
//               initialChildSize: 0.9,
//               maxChildSize: 0.9,
//               minChildSize: 0.9,
//               expand: false,
//               builder: (context, scrollController) {
//                 return CustomScrollView(
//                   controller: scrollController,
//                   scrollDirection: Axis.vertical,
//                   slivers: [
//                     SliverToBoxAdapter(
//                       child: Container(
//                         width: double.infinity,
//                         height: 30,
//                         decoration: BoxDecoration(
//                             color: Colors.primaries[0],
//                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
//                         ),
//                         child: Center(
//                           child: Container(
//                             height: 5,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.white60,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SliverToBoxAdapter(
//                       child: SizedBox(
//                         height: 16,
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       sliver: SliverToBoxAdapter(
//                         child: HelperText().boldText18("Add Content"),
//                       ),
//                     ),
//                     const SliverPadding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       sliver: SliverToBoxAdapter(
//                         child: Text("Select from our wide variety of links and contact info below. (47)"),
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
//                       sliver: SliverGrid.count(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                         childAspectRatio: 3/1,
//                         children: [
//                           ...List.generate(socialNameList.length, (index) {
//                             return Material(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               child: InkWell(
//                                 onTap: (){
//                                   Navigator.of(context).pop();
//                                   socialLinkInputDialog(socialNameList[index],context);
//                                 },
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       FaIcon(Utils.getSocialIcon(socialNameList[index].socialMedia),color: Utils.getSocialIconColor(socialNameList[index].socialMedia),),
//                                       const SizedBox(
//                                         width: 8,
//                                       ),
//                                       Text(socialNameList[index].socialMedia,style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
//                                       const Spacer(),
//                                       Material(
//                                         color: boxTextFieldColor,
//                                         shape: const CircleBorder(),
//                                         child: InkWell(
//                                           onTap: (){
//                                             Navigator.of(context).pop();
//                                             socialLinkInputDialog(socialNameList[index],context);
//                                           },
//                                           borderRadius: BorderRadius.circular(50),
//                                           child: const Padding(
//                                             padding: EdgeInsets.all(4),
//                                             child: Icon(Icons.add),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               }
//           );
//         }
//     );
//   }
//   void socialLinkInputDialog(SocialMedias socialMedia,context){
//     final key = GlobalKey<FormState>();
//     var titleController = TextEditingController();
//     var linkController = TextEditingController();
//     final MtgCardEditController controller = Get.find();
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: const Color(0xFFF4F4F4),
//         elevation: 3,
//         // isDismissible: true,
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
//         ),
//         builder: (context){
//           titleController.text = socialMedia.socialMedia;
//           linkController.text = socialMedia.url;
//           return DraggableScrollableSheet(
//               initialChildSize: 0.9,
//               maxChildSize: 0.9,
//               minChildSize: 0.9,
//               expand: false,
//               builder: (context, scrollController) {
//                 return CustomScrollView(
//                   controller: scrollController,
//                   scrollDirection: Axis.vertical,
//                   slivers: [
//                     SliverToBoxAdapter(
//                       child: Container(
//                         width: double.infinity,
//                         height: 30,
//                         decoration: BoxDecoration(
//                             color: Colors.primaries[0],
//                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
//                         ),
//                         child: Center(
//                           child: Container(
//                             height: 5,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.white60,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SliverToBoxAdapter(
//                       child: SizedBox(
//                         height: 16,
//                       ),
//                     ),
//
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       sliver: SliverToBoxAdapter(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               GestureDetector(
//                                 onTap: (){
//                                   Navigator.of(context).pop();
//                                   chooseSocialLink(context);
//                                 },
//                                 child: Row(
//                                   children: const [
//                                     Icon(Icons.arrow_back),
//                                     SizedBox(
//                                       width: 8,
//                                     ),
//                                     Text("Back"),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               Material(
//                                 color: Colors.white,
//                                 shape: const CircleBorder(),
//                                 child: InkWell(
//                                   onTap: (){
//                                     Navigator.of(context).pop();
//                                   },
//                                   borderRadius: BorderRadius.circular(50),
//                                   child: const Padding(
//                                     padding: EdgeInsets.all(4),
//                                     child: Icon(Icons.close),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
//                       sliver: SliverToBoxAdapter(
//                         child: FaIcon(Utils.getSocialIcon(socialMedia.socialMedia),size: 50,color: Utils.getSocialIconColor(socialMedia.socialMedia),),
//                       ),
//                     ),
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
//                       sliver: SliverToBoxAdapter(
//                         child: Form(
//                           key: key,
//                           child: Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: HelperText().normalText("Profile Link/Username"),
//                               ),
//                               const SizedBox(height: 8,),
//                               CustomEditText().boxEditText(linkController, '', "link", Helper.validationAverage, TextInputType.text,ashColor),
//                               const SizedBox(
//                                 height: 16,
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: HelperText().normalText("Title"),
//                               ),
//                               const SizedBox(height: 8,),
//                               CustomEditText().boxEditText(titleController, '', "title", Helper.validationAverage, TextInputType.text,ashColor),
//                               const SizedBox(
//                                 height: 16,
//                               ),
//                               Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: 45,
//                                     child: OutlinedButton(
//                                       style: OutlinedButton.styleFrom(shape: const StadiumBorder(),side: BorderSide(color: AppColors.mainColor)),
//                                       onPressed: (){},
//                                       child: Text("Cancel",style: TextStyle(fontSize: 12,color: AppColors.mainColor),),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 16,
//                                   ),
//                                   SizedBox(
//                                     height: 48,
//                                     child: OutlinedButton(
//                                       style: OutlinedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: const StadiumBorder(),side: BorderSide(color: AppColors.mainColor,style: BorderStyle.solid)),
//                                       onPressed: (){
//                                         if (key.currentState!.validate()) {
//                                           Utils.loadingDialog(context);
//                                           Future.delayed(const Duration(seconds: 2)).then((value) {
//                                             Utils.closeDialog(context);
//                                             controller.addSocialLinks(SocialMedias(id: socialMedia.id, socialMedia: titleController.text, url: linkController.text));
//                                             Navigator.of(context).pop();
//                                           });
//
//                                         }
//                                       },
//                                       child: Text("Save",style: TextStyle(fontSize: 12,color: AppColors.white),),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }
//           );
//         }
//     );
//   }
// }