import 'package:get/get.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/strings.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../../domain/entities/order_products_entity.dart';

class OrderDetailController extends GetxController {
  late AddressEntity addressEntity;
  late OrderProductsEntity orderProductsEntity;
  StatusRequest statusRequest = StatusRequest.initial;
  String orderStatus = "";

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    addressEntity = args['address'];
    orderProductsEntity = args['orderProducts'];
    orderStatus = args['status'];
  }

  /// 🔹 إرجاع الوصف بناءً على الحالة
  String get orderStatusDescription {
    switch (orderStatus) {
      case 'pending':
        return AppStrings.pendingDescription.tr;
      case 'paid':
        return AppStrings.paidDescription.tr;
      case 'processing':
        return AppStrings.processingDescription.tr;
      case 'shipped':
        return AppStrings.shippedDescription.tr;
      case 'delivered':
        return AppStrings.deliveredDescription.tr;
      case 'cancelled':
        return AppStrings.cancelledDescription.tr;
      case 'refunded':
        return AppStrings.refundedDescription.tr;
      default:
        return "";
    }
  }
}
