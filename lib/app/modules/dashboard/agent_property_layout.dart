import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:flutter/material.dart';

class AgentPropertyLayout extends StatelessWidget {
  const AgentPropertyLayout({Key? key,required this.index}) : super(key: key);
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
                  Container(
                    height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: const Icon(Icons.image,size: 50,color: Colors.grey,)),
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
                              child: HelperText().boldText("Property Title"),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            LayoutBuilder(
                              builder: (context,constraints){
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green,width: 1),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: const Text("Apartment",style: TextStyle(color: Colors.green,fontSize: 12),),
                                );
                              },
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text("Area city with full address",style: TextStyle(color: Colors.black87.withOpacity(0.8),fontSize: 12),),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                              margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.ashTextColor.withOpacity(0.8),width: 1),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Text("Sale",style: TextStyle(color: AppColors.ashTextColor.withOpacity(0.8),fontSize: 10),),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text("PID : #23456",style: TextStyle(color: Colors.black45,fontSize: 12),),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  text: "Aug-12-2022",
                                  style: TextStyle(color: Colors.black45,fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "(3 days)",
                                      style: TextStyle(color: Colors.black,fontSize: 13),
                                    )
                                  ]
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.edit,size: 16,),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text("Edit",style: TextStyle(color: AppColors.mainColor),)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16,),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.close,size: 16,),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text("Delete",style: TextStyle(color: AppColors.mainColor),)
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Details",style: TextStyle(color: AppColors.mainColor),),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                    Icon(Icons.keyboard_arrow_right_outlined,color: AppColors.mainColor,size: 16,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
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
