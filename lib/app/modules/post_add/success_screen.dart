import 'package:mtgpro/app/core/values/colors.dart';
import 'package:mtgpro/app/global_widgets/custom_appbar.dart';
import 'package:mtgpro/app/global_widgets/helper_text.dart';
import 'package:flutter/material.dart';

class PostAdSuccessScreen extends StatelessWidget {
  const PostAdSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().colorAppBar("Post Ad Status",AppColors.mainColor,false),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline_rounded,size: 60,color: Colors.green,),
            const Text("Success",style: TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.w500),),
            HelperText().normalText("You have successfully posted your ad. ",)
          ],
        ),
      ),
    );
  }
}
