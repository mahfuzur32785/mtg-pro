import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/post_add/post_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../core/utils/helpers.dart';
import '../../../global_widgets/custom_edittext.dart';
import '../../../global_widgets/helper_text.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostAdController>(
      builder: (controller){
        return CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelperText().redNormalText("Contact Person Name*"),
                    SizedBox(
                      child: CustomEditText().normalEditText(controller.landAreaController,
                          controller.landArea, "Enter Contact Name", Helper.validationAverage, TextInputType.text),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HelperText().redNormalText("Mobile No*"),
                    const SizedBox(
                      height: 8,
                    ),
                    ...List.generate(controller.contactList.length, (index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.ashTextColor )
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    // height: 60,
                                    child: TextFormField(
                                      // validator: validator,
                                      // controller: controller,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      maxLines: 1,
                                      onChanged: (value){
                                        if (value != "") {
                                          controller.contactList[index] = value.toString();
                                        }
                                      },
                                      onSaved: (String? val) {
                                        // text = val;
                                      },
                                      decoration: InputDecoration(
                                        // filled: true,
                                        // fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                        hintText: index == 0 ? "Enter Contact No" : "Enter another contact no",
                                        hintStyle: TextStyle(color: AppColors.ashTextColor,fontWeight: FontWeight.w400,fontSize: 14),
                                        // labelText: 'Email',
                                        // isDense: true,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Material(
                                  color: index == controller.contactList.length -1 ? AppColors.mainColor : AppColors.ashTextColor,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    onTap: (){
                                      if (index == (controller.contactList.length-1)) {
                                        controller.addContact();
                                      } else {
                                        controller.removeContact(index);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(50),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: index == controller.contactList.length -1
                                          ? const Icon(Icons.add,size: 20,color: Colors.white,)
                                          : const Icon(Icons.close,size: 20,color: Colors.white,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,)
                        ],
                      );
                    }),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                        onPressed: (){
                          controller.pageController.nextPage(duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: const Text("Continue",style: TextStyle(color: Colors.white),),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        );
      },
    );
  }
}
