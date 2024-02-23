import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/theming/colors_manager.dart';

class ButtonUploadIamge extends StatelessWidget {
  final void Function()? onTap;
  const ButtonUploadIamge({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 60.w,
      decoration:
          const BoxDecoration(color: ColorsManager.white, shape: BoxShape.circle),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: SvgPicture.asset('assets/svgs/camera-1389.svg'),
        ),
      ),
    );
  }
}
