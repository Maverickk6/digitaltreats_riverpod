import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF843667);
const kSecondaryColor = Color(0xFF022238);
const kThirdColor = Color(0xFFFFDCB0);
const kLightBackground = Color(0xFFE8F6FB);
const kWhiteColor = Colors.white;
const kBlackColor = Colors.black;

class AppTheme {
  static const kBigTitle = TextStyle(
    color: kWhiteColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static final kBodyText = TextStyle(
    color: Colors.grey.shade400,
    fontSize: 13,
  );

  static const kHeading1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const kseeAllText = TextStyle(color: kPrimaryColor);

  static const kCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
