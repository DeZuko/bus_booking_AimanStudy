import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'constant_color.dart';

const kwstyleBtn15 = TextStyle(
  fontSize: 15,
  color: kcWhite,
  fontWeight: FontWeight.w500,
);

const kwDivider = Divider(
  color: kcDivider,
  endIndent: 0,
  height: 0,
  indent: 0,
  thickness: 1,
);

const kwInset0 = EdgeInsets.zero;

//String
String dateformat(DateTime date, {String format = 'dd-MM-yyyy'}) {
  return DateFormat(format).format(date);
}

String dateformatText(DateTime date) {
  return DateFormat('d MMMM, yyyy').format(date);
}

String dateformatNumSlashI(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String dateformatNumSlashD(DateTime date) {
  return DateFormat('yy/MM/dddd').format(date);
}

String dateformatNumDashI(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String dateformatNumDashD(DateTime date) {
  return DateFormat('yy-MM-dddd').format(date);
}

TextStyle kwtextStyleRD(
    {double fs = 12,
    Color c = Colors.black,
    double? h,
    FontWeight? fw,
    String ff = 'SF Pro Text'}) {
  return TextStyle(
    fontFamily: ff,
    fontSize: fs.sp,
    color: c,
    height: h,
    fontWeight: fw,
  );
}

TextStyle kwtextStyleD(
    {double fs = 12, Color c = Colors.black, double? h, FontWeight? fw}) {
  return TextStyle(
    fontSize: fs,
    color: c,
    height: h,
    fontWeight: fw,
  );
}

SizedBox gapwr({double w = 20}) {
  return SizedBox(width: w.w);
}

SizedBox gaphr({double h = 20}) {
  return SizedBox(height: h.h);
}

SizedBox gapw({double w = 20}) {
  return SizedBox(width: w);
}

SizedBox gaph({double h = 20}) {
  return SizedBox(height: h);
}

Text textBtn15(
  String title, {
  TextStyle style = kwstyleBtn15,
}) {
  return Text(
    title,
    style: style,
  );
}

Divider divider({Color c = kcDivider, double t = 1}) {
  return Divider(
    color: c,
    thickness: t,
    endIndent: 0,
    height: 0,
    indent: 0,
  );
}

EdgeInsetsGeometry padSymR({double h = 20, double v = 0}) {
  return EdgeInsets.symmetric(horizontal: h.w, vertical: v.h);
}

EdgeInsetsGeometry padSym({h = 20, v = 0}) {
  return EdgeInsets.symmetric(horizontal: h, vertical: v);
}

EdgeInsetsGeometry padOnlyR({
  double l = 0,
  double t = 0,
  double r = 0,
  double b = 0,
}) {
  return EdgeInsets.only(left: l.w, top: t.h, right: r.w, bottom: b.h);
}

EdgeInsetsGeometry padOnly({
  double l = 0,
  double t = 0,
  double r = 0,
  double b = 0,
}) {
  return EdgeInsets.only(left: l, top: t, right: r, bottom: b);
}

BorderRadius borderRadiuscR({double r = 10}) {
  return BorderRadius.circular(r.r);
}

RoundedRectangleBorder cornerR({double r = 10}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(r.r),
  );
}

RoundedRectangleBorder corner({double r = 10}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(r),
  );
}
const kfregular = FontWeight.w400;
const kfmedium = FontWeight.w500;
const kfsemibold = FontWeight.w600;
const kfbold = FontWeight.bold;
const kfextrabold = FontWeight.w800;
const kfblack = FontWeight.w900;

//textstyle
const TextStyle kwlabelStyle = TextStyle(
    fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: kcBlack);

const TextStyle kwinputStyle = TextStyle(
    fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kcBlack);

