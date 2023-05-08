import 'package:flutter/material.dart';
import 'package:mtgpro/app/core/utils/constants.dart';

class RowView {
  static TableRow dataRow(String sl, String cardTitle, String visitCount,
      // String deviceId,
      String timeZone, String userAgent, String address) {
    return TableRow(
      children: [
        viewRow(sl),
        viewRow(cardTitle),
        viewRow(visitCount),
        // viewRow(deviceId),
        viewRow(timeZone),
        viewRow(userAgent),
        viewRow(address),
      ]
    );
  }
}
