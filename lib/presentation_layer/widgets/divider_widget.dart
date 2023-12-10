import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDivider(double endIndent) {
  return Divider(
    color: Colors.amber,
    endIndent: endIndent,
    height: 30.0.h,
    thickness: 3.0,
  );
}
