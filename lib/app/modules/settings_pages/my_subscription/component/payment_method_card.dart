import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/values/k_images.dart';
import '../../../../global_widgets/custom_image.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({Key? key}) : super(key: key);

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
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.blue,textStyle: TextStyle(fontWeight: FontWeight.w600)),
                onPressed: (){},
                child: const Text("Change Card"),
              ),
              // GestureDetector(
              //   onTap: (){},
              //     child: const Text("Change Card",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),)
              // )
            ],
          ),
        ],
      ),
    );
  }
}
