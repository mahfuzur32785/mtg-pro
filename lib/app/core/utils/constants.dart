
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFFffff);
const Color blackColor = Color(0xff0B2C3D);
const Color whiteColor = Color(0xFFFFFFFF);
const Color f4f4Color = Color(0xFFF4F4F4);
const Color borderColor = Color(0xFFB0D8FF);
const Color pDetailsColor = Color(0xFFF0F8FF);
const Color greenColor = Color(0xFF34A853);
const Color ashColor = Color(0xFFE7ECEF);
const Color ashTextColor = Color(0xff989eb1);
final Color grayColor = const Color(0xff0B2C3D).withOpacity(.3);
const Color iconThemeColor = Color(0xffffffff);
// const Color redColor = Color(0xffFF5200);
const Color redColor = Color(0xfff27319);
// const Color redColor = Color(0xffFFBB38);
const Color iconGreyColor = Color(0xff85959E);
const Color paragraphColor = Color(0xff18587A);
const Color bgGreyColor = Color(0xffE8EEF2);
const Color boxTextFieldColor = Color(0xffF7F7F7);
const greenGradient = [redColor, redColor];

const kDuration = Duration(seconds: 2);
const kDuration1 = Duration(seconds: 1);
const kDuration0 = Duration(seconds: 0);

final borderRadius = BorderRadius.circular(4);

double screenWidth(BuildContext context)  {
  return MediaQuery.of(context).size.width;
}
double screenHeight(BuildContext context)  {
  return MediaQuery.of(context).size.height;
}

var inputDecorationTheme = InputDecoration(
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  hintStyle: const TextStyle(fontSize: 18, height: 1.667),
  border: OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: ashColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: ashColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: ashColor),
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(color: Colors.red)
  ),
  fillColor: primaryColor,
  filled: true,
  focusColor: blackColor,
);

final gradientColors = [
  [redColor, redColor.withOpacity(0.7)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
  [const Color(0xffFFFFFF), const Color(0xffFFFFFF)],
];

Widget viewRow(value){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text("$value", maxLines: 4, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0),),
  );
}
