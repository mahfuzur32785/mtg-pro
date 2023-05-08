import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/modules/more/more_controller.dart';
class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      init: MoreController(),
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                title: Text("More",style: TextStyle(color: AppColors.mainColor),),
                backgroundColor: Colors.white,
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark,statusBarColor: Colors.white),
                elevation: 0,
                titleSpacing: 0,
                pinned: true,
                leading: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.document_scanner,color: AppColors.mainColor),
                ),
                actions: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.add,color: AppColors.mainColor),
                  )
                ],
              ),
              const SliverToBoxAdapter(
                child: Divider(
                  height: 1,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
