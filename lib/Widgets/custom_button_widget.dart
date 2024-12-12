import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled2/Utilities/extensions.dart';

import '../common/colors/theme_model.dart';
import '../common/text_style_helper.dart';

class CustomButtonWidget extends StatelessWidget {
  final bool isLoading;
  final Function()? onPressed;
  final double? width, height, borderRadiusValue;
  final String? title;
  final Widget? child;
  final Color? btnColor, titleColor;
  final Color? borderColor;
  const CustomButtonWidget(
      {super.key,
      this.width,
      this.height,
      this.title,
      this.onPressed,
      this.child,
      this.borderRadiusValue,
      this.isLoading = false,
      this.btnColor,
      this.borderColor,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 48.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusValue ?? 8.h),
          color: btnColor,
          border: borderColor == null ? null : Border.all(color: borderColor!),
        ),
        child: isLoading
            ? Center(
                child: SpinKitThreeBounce(
                    color: ThemeModel.of(context).font1, size: 24.r))
            : child ??
                Text(
                  title ?? "",
                  style: TextStyleHelper.of(context).regular16.copyWith(
                      color: titleColor ?? ThemeModel.of(context).font1),
                ),
      ),
    );
  }
}

class OutlinedButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final double? width, height;
  final String? title, iconPath;
  final Widget? child;
  final Color? titleColor, borderColor;
  const OutlinedButtonWidget(
      {super.key,
      this.width,
      this.height,
      this.title,
      this.iconPath,
      this.child,
      this.titleColor,
      this.borderColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40.h,
        width: width ?? 120.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            color: Colors.transparent,
            border: Border.all(
                color: borderColor ?? ThemeModel.of(context).font4, width: 1)),
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconPath != null)
                  SvgPicture.asset(
                    iconPath!,
                    colorFilter: ColorFilter.mode(
                        borderColor ?? ThemeModel.of(context).font1,
                        BlendMode.srcIn),
                    height: 16.r,
                    width: 16.r,
                  ),
                if (iconPath != null) 8.w.widthBox,
                Text(
                  title ?? "",
                  style: TextStyleHelper.of(context).regular16.copyWith(
                      color: titleColor ?? ThemeModel.of(context).font1),
                ),
              ],
            ),
      ),
    );
  }
}
