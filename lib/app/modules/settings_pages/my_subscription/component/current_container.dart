import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/values/k_images.dart';
import '../../../../global_widgets/custom_image.dart';

class CurrentContainer extends StatefulWidget {
  const CurrentContainer({Key? key}) : super(key: key);

  @override
  State<CurrentContainer> createState() => _CurrentContainerState();
}

class _CurrentContainerState extends State<CurrentContainer> {

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
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(-5, -5)),
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(5, 5)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Current Plan",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                    const SizedBox(height: 8,),
                    const Text("Yearly",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text("\$149.00/year",style: TextStyle(color: Colors.deepOrange,
                            fontSize: 14,fontWeight: FontWeight.w500),)),
                    const Text("Status"),
                    Row(
                      children: [
                        const Icon(Icons.check_box,color: Colors.green,size: 20,),
                        const SizedBox(width: 6,),
                        Text("Active",style: GoogleFonts.kanit(),)
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 16),
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(foregroundColor: AppColors.white,
                            backgroundColor: AppColors.mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                        onPressed: (){},
                        child: const Text("Upgrade Plan"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 16),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(foregroundColor: AppColors.mainColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                        onPressed: (){},
                        child: const Text("Cancel Subscription"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: const TextSpan(
                text: "Member since ",
                style: TextStyle(color: Colors.black54),
                children: <TextSpan>[
                  TextSpan(
                    text: "January 29,2023",
                    style: TextStyle(color: Colors.black87),
                  ),
                ]
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          RichText(
            text: const TextSpan(
                text: "Renew Subscription by ",
                style: TextStyle(color: Colors.black54),
                children: <TextSpan>[
                  TextSpan(
                    text: "January 29,2024",
                    style: TextStyle(color: Colors.black87),
                  ),
                ]
            ),
          ),
          const Divider(
            height: 50,
            color: ashColor,
          ),
          Text("Billing Information",style: GoogleFonts.merriweatherSans(),),
          const SizedBox(
            height: 10,
          ),
          const Text("Bangladesh"),
          const Text("amirkhan66@gmail.com"),
          const Text("Zipcode : 1212"),
          const Divider(
            height: 50,
            color: ashColor,
          ),
          Text("Payment Method",style: GoogleFonts.merriweatherSans(),),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const CustomImage(path: KImages.paymentMastercardIcon,height: 30,),
              const SizedBox(width: 8,),
              const Text("********2354"),
              const Spacer(),
              GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Text("Change Card",style: TextStyle(color: isTap ? Colors.black87 : Colors.blue,fontWeight: FontWeight.w600),)
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
