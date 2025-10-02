import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Statics {


  late double width;
  late double height;

  Statics() {
    width = Get.width;
    height = Get.height;
  }

  double get mainHeadingSize => _responsiveSpace(22.px, 24.px, 26.px, 28.px, 30.px);
  double get subHeadingSize => _responsiveSpace(14.px, 16.px, 18.px, 20.px, 22.px);

  double get bodyTextSize => _responsiveSpace(14.px, 16.px, 18.px, 20.px, 22.px);
  double get subtitleTextSize => _responsiveSpace(10.px, 12.px, 14.px, 16.px, 18.px);
  double get premiumTextSize => _responsiveSpace(32.px, 34.px, 36.px, 38.px, 40.px);
  double get dialogHeadingSize => _responsiveSpace(15.px, 17.px, 19.px, 21.px, 23.px);


  double get defaultIconSize => _responsiveSpace(20.px, 20.px, 20.px, 22.px, 22.px);
  double get defaultPadding => _responsiveSpace(22.px, 24.px, 26.px, 28.px, 30.px);
  double get bottomBarHeight => _responsiveSpace(101.px, 103.px, 105.px, 107.px, 109.px);

  double get largeIconSize => _responsiveSpace(46.px, 48.px, 50.px, 52.px, 54.px);


  double get premiumIconBox => _responsiveSpace(46.px, 48.px, 50.px, 52.px, 54.px);
  double get premiumIconBoxPadding => _responsiveSpace(8.px, 10.px, 12.px, 14.px, 16.px);
  double get inputContainerHeight => _responsiveSpace(158.px, 160.px, 162.px, 164.px, 169.px);
  double get loadingAnimationSize => _responsiveSpace(190.px, 200.px, 210.px, 220.px, 230.px);


  double get subscriptionContainerHeight => _responsiveSpace(240.px, 255.px, 260.px, 300.px, 23.px);
  double get renewContainerHeight => _responsiveSpace(68.px, 70.px, 72.px, 76.px, 23.px);

  double get xHeading => _responsiveSpace(18.sp, 16.sp, 14.sp, 14.sp, 14.sp);
  double get lHeading => _responsiveSpace(19.sp, 18.sp, 16.sp, 15.sp, 15.sp);
  double get xHeadingA => _responsiveSpace(16.sp, 15.sp, 14.sp, 13.sp, 13.sp);
  double get xHeadingACustom => _responsiveSpace(17.sp, 16.sp, 15.sp, 14.sp, 13.sp);
  double get heading => _responsiveSpace(14.sp, 14.sp, 10.sp, 12.sp, 12.sp);
  double get headingB => _responsiveSpace(14.sp, 14.sp, 10.sp, 15.sp, 15.sp);
  double get headingA => _responsiveSpace(14.sp, 13.sp, 10.sp, 12.sp, 12.sp);
  double get label => _responsiveSpace(14.sp, 12.sp, 10.sp, 12.sp, 12.sp);
  double get chipLabel => _responsiveSpace(15.sp, 13.sp, 11.sp, 11.sp, 9.sp);
  double get subtitleLabel => _responsiveSpace(16.sp, 14.sp, 12.sp, 12.sp, 10.sp);
  double get smallLabel => _responsiveSpace(12.sp, 11.sp, 8.sp, 11.sp, 11.sp);
  double get xSmallLabel => _responsiveSpace(10.sp, 8.sp, 6.sp, 4.sp, 2.sp);
  double get xlSmallLabel => _responsiveSpace(8.sp, 6.sp, 4.sp, 2.sp, 1.sp);
  double get xxlSmallLabel => _responsiveSpace(6.sp, 4.sp, 2.sp, 1.sp, 1.sp);

  double get iconExtraSmallSize => _responsiveSpace(12.sp, 15.sp, 15.sp, 14.sp, 14.sp);
  double get iconExtraASmallSize => _responsiveSpace(8.sp, 16.sp, 12.sp, 14.sp, 16.sp);
  double get iconSmallSize => _responsiveSpace(14.sp, 18.sp, 18.sp, 16.sp, 16.sp);
  double get iconSmallASize => _responsiveSpace(14.sp, 18.sp, 18.sp, 18.sp, 18.sp);
  double get iconMediumSize => _responsiveSpace(18.sp, 20.sp, 22.sp, 20.sp, 20.sp);
  double get iconMediumLargeSize => _responsiveSpace(20.px, 22.px, 27.px, 30.px, 34.px);
  double get iconLargeSize => _responsiveSpace(25.sp, 36.sp, 35.sp, 35.sp, 35.sp);

  double get extraSmallSpace => _responsiveSpace(4.sp, 8.sp, 8.sp, 10.sp, 12.sp);
  double get extraXSmallSpace => _responsiveSpace(4.sp,4.sp, 8.sp, 8.sp, 7.sp);
  double get smallSpace => _responsiveSpace(10.sp, 10.sp, 12.sp, 12.sp, 12.sp);
  double get smallBSpace => _responsiveSpace(10.sp, 14.sp, 12.sp, 12.sp, 12.sp);
  double get smallDSpace => _responsiveSpace(10.sp, 16.sp, 12.sp, 14.sp, 14.sp);
  double get smallCSpace => _responsiveSpace(10.sp, 16.sp, 16.sp, 15.sp, 15.sp);
  double get toastSpace => _responsiveSpace(10.sp, 12.sp, 15.sp, 15.sp, 20.sp);
  double get smallASpace => _responsiveSpace(6.sp, 10.sp, 10.sp, 20.sp, 25.sp);
  double get smallAASpace => _responsiveSpace(6.sp, 12.sp, 10.sp, 20.sp, 20.sp);
  double get smallAAASpace => _responsiveSpace(8.sp, 14.sp, 10.sp, 20.sp, 20.sp);
  double get mediumSpace => _responsiveSpace(12.sp, 18.sp, 20.sp, 18.sp, 18.sp);
  double get mediumASpace => _responsiveSpace(12.sp, 26.sp, 20.sp, 22.sp, 22.sp);
  double get mediumAASpace => _responsiveSpace(12.sp, 22.sp, 20.sp, 22.sp, 22.sp);
  double get mediumToolScreenSpace => _responsiveSpace(12.sp, 19.sp, 20.sp, 100.sp, 100.sp);
  double get largeSpace => _responsiveSpace(8.sp, 25.sp, 30.sp, 25.sp, 25.sp);
  double get doneBarHeight => _responsiveSpace(30.sp, 28.sp, 30.sp, 25.sp, 25.sp);
  double get extraLargeSpace => _responsiveSpace(20.sp, 20.sp, 40.sp, 45.sp, 50.sp);
  double get premiumIconWidth => _responsiveSpace(30.sp, 35.sp, 60.sp, 35.sp, 35.sp);
  double get minusSpace => _responsiveSpace(20, 29.sp, 34.sp, 24.sp, 25.sp);
  double get minusExtraSpace => _responsiveSpace(40.sp, 60.sp, 80.sp, 120.sp, 170.sp);
  double get addSpace => _responsiveSpace(30.sp, 35.sp, 50.sp, 30.sp, 30.sp);
  double get bottomPadding => _responsiveSpace(30.sp, 50.sp, 50.sp, 30.sp, 38.sp);

  double get textSpace => _responsiveSpace(30.sp,47.sp, 48.sp, 40.sp, 40.sp);
  double get dialogHeight => _responsiveSpace(28.sp, 38.sp, 36.sp, 34.sp, 35.sp);

  double get leftSideSmallPosition => _responsiveSpace(0.1,.1,.1,.1,.1,);
  double get leftSideMediumPosition => _responsiveSpace(0.2,.2,.2,.2,.2,);
  double get leftSideLargePosition => _responsiveSpace(0.3,.3,.3,.3,.3,);
  double get rightSideSmallPosition => _responsiveSpace(0.1,.1,.1,.1,.1,);
  double get rightSideMediumPosition => _responsiveSpace(0.2,.2,.2,.2,.2,);
  double get rightSideLargePosition => _responsiveSpace(0.3,.3,.3,.3,.3,);



  /// Returns a responsive spacing value based on device screen size and orientation.
  /// Helps adjust padding, margin, font size, etc. across different devices.
  ///
  /// Parameters:
  /// - [extraSmallSize]: Value for very small phones (<360 width).
  /// - [smallSize]: Value for small phones (360–479 width).
  /// - [mediumSize]: Value for tablets in portrait or smaller landscape phones (480–767 width).
  /// - [largeSize]: Value for tablets (768–1023 width).
  /// - [extraLargeSize]: Value for desktops or large tablets (1024+ width).
  double _responsiveSpace(
      double extraSmallSize,
      double smallSize,
      double mediumSize,
      double largeSize,
      double extraLargeSize,
      ) {
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;
    final bool isPortrait = screenHeight > screenWidth;

    if (screenWidth < 360 && isPortrait) {
      // 📱 Extra small devices (e.g. iPhone 4, Galaxy Pocket, older Androids)
      return extraSmallSize;
    } else if (screenWidth < 480 && isPortrait) {
      // 📱 Small phones (e.g. iPhone SE 2020/2022, Pixel 4a, Galaxy A01)
      return smallSize;
    } else if (screenWidth < 768) {
      // 📲 Medium phones and phablets (e.g. iPhone 13 Pro Max, Galaxy S23+, Pixel 7 Pro)
      return mediumSize;
    } else if (screenWidth < 1024) {
      // 💻 Tablets (e.g. iPad Mini, Galaxy Tab A7, Lenovo Tab M10)
      return isPortrait ? largeSize : largeSize * 1.1;
    } else {
      // 🖥️ Desktops or large tablets (e.g. iPad Pro 12.9", Surface Pro, Chromebook)
      return extraLargeSize;
    }
  }


// double _responsiveSpace(
//     double extraSmallSize,
//     double smallSize,
//     double mediumSize,
//     double largeSize,
//     double extraLargeSize
//     ) {
//   double screenWidth = Get.width;
//   double screenHeight = Get.height;
//   bool isPortrait = screenHeight > screenWidth;
//
//   if (screenWidth < 360 && isPortrait) {
//     return extraSmallSize;
//   } else if (screenWidth < 480 && isPortrait) {
//     return smallSize;
//   }
//   else if (screenWidth < 1024) {
//     return isPortrait ? largeSize : largeSize * 1.1;
//   } else {
//     return extraLargeSize;
//   }
// }
}