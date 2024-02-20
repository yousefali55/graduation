import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget heightSpace(double height) {
  return SizedBox(
    height: height.h,
  );
}

Widget widthSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}
