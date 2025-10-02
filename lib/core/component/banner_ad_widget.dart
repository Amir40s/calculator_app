// import 'dart:io';
// import 'package:aipoemgenerator/config/res/app_ids.dart';
// import 'package:aipoemgenerator/core/controller/types_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../config/enum/style_type.dart';
// import '../../config/res/statics.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// import '../controller/purchase_manager.dart';
// import '../controller/theme_controller.dart';
// import 'app_text_widget.dart';
//
// class BannerAdWidget extends StatelessWidget {
//   BannerAdWidget({super.key});
//
//   // final PurchaseManager adsManager = Get.find<PurchaseManager>();
//   final  adsManager = Get.find<PurchaseManager>();
//   final ThemeController themeController = Get.find<ThemeController>();
//   // final RemoteConfigController remoteCon = Get.find<RemoteConfigController>();
//   final Statics static = Statics();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       // If user is subscribed, no ad
//       if (adsManager.isSubscribed.value) return const SizedBox.shrink();
//       return FutureBuilder<BannerAd?>(
//         future: _loadAd(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return _loadingShimmer();
//           }
//
//           // if (snapshot.hasError || snapshot.data == null ||
//           //     adsManager.adsErrorMessage.isNotEmpty) {
//           //   return _errorWidget();
//           // }
//
//           if (snapshot.hasError || snapshot.data == null ) {
//             return _errorWidget();
//           }
//
//
//           return SafeArea(
//             child: SizedBox(
//               width: Get.width,
//               height: AdSize.banner.height.toDouble(), // 50.0
//               child: AdWidget(ad: snapshot.data!),
//             ),
//           );
//         },
//       );
//     });
//   }
//
//   Future<BannerAd?> _loadAd() async {
//     final bannerAd = BannerAd(
//       adUnitId: AppIds.bannerAdId ,
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           // adsManager.isAdsLoading.value = false;
//           // adsManager.adsErrorMessage.value = "";
//           debugPrint("Ad loaded successfully");
//           // adsManager.update();
//         },
//         onAdFailedToLoad: (ad, error) {
//           // adsManager.isAdsLoading.value = false;
//           // adsManager.adsErrorMessage.value = "Ad not available";
//           debugPrint("Ad failed to load: $error");
//           // adsManager.update();
//           ad.dispose();
//         },
//       ),
//     );
//
//     await bannerAd.load();
//     return bannerAd;
//   }
//
//   Widget _loadingShimmer() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Container(
//         width: Get.width,
//         height: AdSize.banner.height.toDouble(),
//         color: Colors.grey,
//       ),
//     );
//   }
//
//   Widget _errorWidget() {
//     return Container(
//       width: Get.width,
//       height: AdSize.banner.height.toDouble(),
//       alignment: Alignment.center,
//       color: Theme.of(Get.context!).highlightColor,
//       child: AppTextWidget(
//         text: "Loading Ad...",
//         styleType: StyleType.body,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }
