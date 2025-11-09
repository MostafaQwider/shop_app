import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/assets_manager.dart';
import '../../core/constants/enums.dart';
import '../component/app_button.dart'; // ✅ لاستخدام الزر AppButton

/// Widget يستخدم لإدارة حالات البيانات (loading, error, success...).
class HandlingData extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget child;
  final bool showLoading;
  final Widget? loadingWidget;
  final VoidCallback? onTryAgain; // ✅ متحول جديد للزر

  const HandlingData({
    super.key,
    required this.statusRequest,
    required this.child,
    this.showLoading = true,
    this.loadingWidget,
    this.onTryAgain, // ✅ إضافته هنا
  });

  @override
  Widget build(BuildContext context) {
    final double size = Get.width * 0.5;

    // 🧭 خريطة الحالات والأنيميشن
    final Map<StatusRequest, String> lottieAssets = {
      StatusRequest.offline: AssetsManager.offline,
      StatusRequest.failure: AssetsManager.server,
      StatusRequest.serverError: AssetsManager.server,
      StatusRequest.exception: AssetsManager.server,
      StatusRequest.nodata: AssetsManager.noData,
    };

    switch (statusRequest) {
      case StatusRequest.loading:
        if (!showLoading) return child;
        return Center(
          child: loadingWidget ??
              Lottie.asset(AssetsManager.loading, width: size, height: size),
        );

      case StatusRequest.offline:
      case StatusRequest.failure:
      case StatusRequest.serverError:
      case StatusRequest.exception:
        final lottiePath =
            lottieAssets[statusRequest] ?? AssetsManager.server;
        return _buildErrorWidget(
          context,
          lottiePath,
          statusRequest.message,
          size,
          showRetry: true, // ✅ عرض الزر
        );

      case StatusRequest.nodata:
        final lottiePath =
            lottieAssets[statusRequest] ?? AssetsManager.noData;
        return _buildErrorWidget(
          context,
          lottiePath,
          statusRequest.message,
          size,
          showRetry: false, // ❌ بدون زر في حالة no data
        );

      case StatusRequest.success:
      case StatusRequest.initial:
        return child;

      default:
        return const SizedBox.shrink();
    }
  }

  /// 🔹 ويدجت عرض الخطأ مع خيار "Try Again"
  Widget _buildErrorWidget(
      BuildContext context,
      String lottieAssets,
      String message,
      double size, {
        required bool showRetry,
      }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(lottieAssets, width: size, height: size),
          const SizedBox(height: 10),
          Text(
            message.isNotEmpty ? message : "حدث خطأ غير متوقع",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (showRetry) ...[
            const SizedBox(height: 20),
            AppButton(
              text: "Try Again",
              onPressed: onTryAgain ??
                      () {
                    // fallback لو ما تم تمرير دالة
                    Get.snackbar("تنبيه", "لم يتم تمرير دالة المحاولة مرة أخرى");
                  },
            ),
          ],
        ],
      ),
    );
  }
}
