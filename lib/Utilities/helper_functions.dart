import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/rounded_image_widget.dart';
import '../common/colors/theme_model.dart';
import '../model/images_model.dart';

class HelperFunctions {
  static void showDialogHelper(BuildContext context,
      {required Widget contentWidget,
      Color? backgroundColor,
      bool isFullScreen = true}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: ThemeModel.of(context).backgroundColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              content: contentWidget,
            ));
  }

  static void imagePreviewDialog(
    BuildContext context, {
    String? imagePath,
    GenericFile? file,
  }) {
    showDialogHelper(
      context,
      contentWidget: RoundedImage(
        // height: 280,
        // width: 200,
        radiusValue: 8,
        imagePath: imagePath,
        memoryImage: file,
      ),
    );
  }
}
