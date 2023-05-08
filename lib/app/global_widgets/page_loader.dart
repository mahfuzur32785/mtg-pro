import 'package:flutter/material.dart';

import '../core/values/colors.dart';
class PageLoader extends StatelessWidget {
  const PageLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
