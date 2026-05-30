import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';

/// ScreenUtil wrapper for easy responsive sizing
/// Design frame: 375 x 812 (iPhone 14 size matching Figma)
class Dimens {
  Dimens._();

  static double w(double value) => value.w;

  static double h(double value) => value.h;

  static double sp(double value) => value.sp;

  static double r(double value) => value.r;

  static double get screenWidth => 1.sw;

  static double get screenHeight => 1.sh;

  static double get statusBarHeight => ScreenUtil().statusBarHeight;

  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  static double get paddingXS => 4.w;
  static double get paddingS => 8.w;
  static double get paddingM => 16.w;
  static double get paddingL => 24.w;
  static double get paddingXL => 32.w;
  static double get paddingXXL => 48.w;

  static double get radiusS => 8.r;
  static double get radiusM => 12.r;
  static double get radiusL => 16.r;
  static double get radiusXL => 24.r;
  static double get radiusXXL => 32.r;
  static double get radiusCircle => 100.r;

  static double get iconS => 18.r;
  static double get iconM => 24.r;
  static double get iconL => 32.r;
  static double get iconXL => 48.r;

  static double get fabSize => 56.r;
}
