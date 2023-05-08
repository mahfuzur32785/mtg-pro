import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:flutter/material.dart';

class LeadsLayout extends StatelessWidget {
  const LeadsLayout({Key? key,required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.f0f0f0,
                    radius: 35,
                    child: const Icon(Icons.person,size: 40,color: Colors.white,),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: HelperText().redNormalText("Saker Ali"),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            LayoutBuilder(
                              builder: (context,constraints){
                                if (index%4==0) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.ashTextColor.withOpacity(0.8),width: 1),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: Text("Project Lead",style: TextStyle(color: AppColors.ashTextColor.withOpacity(0.8),fontSize: 12),),
                                  );
                                } else {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.verified_user_rounded,size: 16,color: Colors.green,),
                                      SizedBox(
                                        width: 0
                                      ),
                                      Text("Verified",style: TextStyle(color: Colors.green,fontSize: 12),)
                                    ],
                                  );
                                }
                              },
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text("Interested On 1500 sf in Mirpur,Dhaka",style: TextStyle(color: Colors.black87.withOpacity(0.8),fontSize: 13),),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text("100%",style: TextStyle(color: Colors.black,fontSize: 15),),
                                Text("matched",style: TextStyle(color: Colors.black45,fontSize: 12),),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text("Aug-12-2022",style: TextStyle(color: Colors.black45,fontSize: 12),),
                            const Spacer(),
                            const Text("LID : #23456",style: TextStyle(color: Colors.black45,fontSize: 12),),
                            const Spacer(),
                            GestureDetector(
                              onTap: (){},
                              child: Text("Details",style: TextStyle(color: AppColors.mainColor,decoration: TextDecoration.underline),),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
