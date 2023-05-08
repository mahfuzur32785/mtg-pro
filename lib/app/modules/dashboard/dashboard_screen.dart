import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/dashboard/agent_property_layout.dart';
import 'package:mtgpro/app/modules/dashboard/leads_layout.dart';
import 'package:mtgpro/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    const Text("Account Balance"),
                    const SizedBox(
                      height: 8,
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.mainColor,
                      radius: 70,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Tk. 10000",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                            Text("AVAILABLE",style: TextStyle(color: Colors.white,fontSize: 12),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){},
                        child: Row(
                          children: const [
                            Text("Recharge Now"),
                            Icon(Icons.keyboard_arrow_right_outlined)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.insert_chart_rounded,color: AppColors.ashTextColor,),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Properties",style: TextStyle(),),
                                const Spacer(),
                                Icon(Icons.keyboard_arrow_right_outlined,color: AppColors.ashTextColor,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.supervised_user_circle,color: AppColors.ashTextColor,),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Leads"),
                                const Spacer(),
                                Icon(Icons.keyboard_arrow_right_outlined,color: AppColors.ashTextColor,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.monetization_on_rounded,color: AppColors.ashTextColor,),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Payments"),
                                const Spacer(),
                                Icon(Icons.keyboard_arrow_right_outlined,color: AppColors.ashTextColor,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(
            height: 16,
            thickness: 8,
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text("Do you have property for \nsale or rent?",style: TextStyle(color: Colors.black87,fontSize: 15),),
                ),
                Material(
                  color: AppColors.f0f0f0,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: (){
                      Get.toNamed(Routes.postAd);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.mainColor,
                          child: const Center(
                            child: Icon(Icons.add,size: 20,color: Colors.white,),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Post Ad",style: TextStyle(color: Colors.black),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: Divider(
            height: 16,
            thickness: 8,
          ),
        ),
        //.............. Seller Leads ..............
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index){
            return LeadsLayout(index: index,);
          },childCount: 3),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                onPressed: (){},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("View All",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ),
        ),

        //.............. Agent Property .............
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index){
            return AgentPropertyLayout(index: index,);
          },childCount: 3),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                onPressed: (){},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("View All",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}