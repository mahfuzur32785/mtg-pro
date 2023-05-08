import 'package:flutter/material.dart';
import 'package:mtgpro/app/core/values/colors.dart';

class PageRefresh extends StatelessWidget {
  PageRefresh({Key? key, required this.onTap, required this.child}) : super(key: key);
  final Function onTap;
  final Widget child;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: AppColors.mainColor,
        strokeWidth: 2.0,
        onRefresh: () => onTap(),
        child: child
    );
  }
}
