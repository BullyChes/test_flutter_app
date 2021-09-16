import 'package:flutter/cupertino.dart';

typedef BoolValue = Function(bool);
typedef IntValue = Function(int);

const kWhiteColor = Color(0xffffffff);
const kBlackColor = Color(0xff000000);
const kBackgroundColor = Color(0xff1d202b);
const kPrimaryColor = Color(0xfff9784b);
const kPrimaryDarkColor = Color(0xffCE552A);
const kGrayTextColor = Color(0xff666666);
const kTextColor = Color(0xff111111);

const kPrimaryGradient = LinearGradient(
  begin: Alignment(-1, 4),
  end: Alignment(1, -4),
  colors: [kPrimaryColor, kPrimaryDarkColor],
);

const kBlackGradient = LinearGradient(
    colors: [kBlackColor, kBackgroundColor],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft);
