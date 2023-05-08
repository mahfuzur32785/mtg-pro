import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtgpro/app/modules/home_cards/component/card_option_container.dart';

import '../../../core/utils/my_sharedpreferences.dart';
import '../../../core/values/colors.dart';

class LetsConnectCardLayout extends StatelessWidget {
  const LetsConnectCardLayout({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: (){
          MySharedPreference.isCard().then((value) => print("$value"));
          // CardOptionContainer.cardOptions(context, index);
        },
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.primaries[index%10]
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Image(
                          image: AssetImage("assets/images/arif.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 9,
                      left: -20,
                      right: -20,
                      child: SvgPicture.asset(
                        height: 45,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        color: Colors.primaries[index%10],
                        "assets/images/wave_n.svg",),
                    ),
                    Positioned(
                      bottom: -1,
                      left: -20,
                      right: -20,
                      child: SvgPicture.asset(
                        height: 50,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        color: Colors.white,
                        "assets/images/wave_n.svg",),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Personal",style: TextStyle(color: Colors.black,fontSize: 16,),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
