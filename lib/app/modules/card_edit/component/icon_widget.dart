import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/extensions.dart';
import '../../../data/remote_urls.dart';
import '../../../global_widgets/custom_image.dart';

class CardIconWidget extends StatelessWidget {
  const CardIconWidget({Key? key, required this.icon, required this.iconColor, required this.size}) : super(key: key);
  final String icon;
  final String iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        if (icon.split(".").toList().last == "svg") {
          return Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: iconColor != ''
                      ? HexColor.fromHex(iconColor)
                      : Colors.black87,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: SvgPicture.network('${RemoteUrls.rootUrl}$icon', height: size-6,width: size-6,)
          );
        } else {
          return Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4)
              ),
              child: CustomImage(path: "${RemoteUrls.rootUrl}$icon",height: size,width: size,fit: BoxFit.cover,)
          );
        }
      },
    );
  }
}
