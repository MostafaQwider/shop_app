import 'package:get/get.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/strings.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../../domain/entities/order_products_entity.dart';
import '../../../../domain/entities/orders_entity.dart';
import '../../../../domain/entities/payment_config_entity.dart';
import '../../../../domain/use_cases/orders/update_orders_usecase.dart';
import '../../../../domain/use_cases/payment/payment_config_usecase.dart';
import '../../../component/app_snack_bar.dart';
import '../../../routes/app_routes.dart';

class OrderDetailController extends GetxController {
  final PaymentConfigUseCase paymentConfigUseCase;
  final UpdateOrderUseCase updateOrderUseCase;
  OrderDetailController(this.updateOrderUseCase,this.paymentConfigUseCase);
  late AddressEntity addressEntity;
  late OrderProductsEntity orderProductsEntity;
  StatusRequest statusRequest = StatusRequest.initial;
  String orderStatus = "";
  late PaymentConfigEntity paymentConfigEntity;

  @override
  void onInit() async{
    super.onInit();
    final args = Get.arguments;
    addressEntity = args['address'];
    orderProductsEntity = args['orderProducts'];

    orderStatus = args['status'];
    print(orderStatus);
    if(orderStatus=="pending"){
      statusRequest = StatusRequest.loading;
      update();
     await getPaymentConfig();
      statusRequest = StatusRequest.initial;
      update();
    }
  }
  Future<void> getPaymentConfig() async {
    final result = await paymentConfigUseCase();
    result.fold((error) => null, (data) => paymentConfigEntity = data.data);
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
  Future<void>pay()async{
    final paymentResult = await Get.toNamed(
      AppRoutes.payOrderRoute,
      arguments: {
        'orderId': orderProductsEntity.order.id,
      },
    );
    // التحقق من نتيجة الدفع وتحديث الطلب
    if (paymentResult != null && paymentResult['status'] == 'success') {
      final transactionId = paymentResult['transactionId'];
      updateOrder( transactionId);
      Get.offNamed(AppRoutes.paymentSuccessRoute);
    } else {
      showToastMessage(
          label: "Payment Failed",
          text: "Payment was cancelled or failed.");
    }
  }
  Future<void>updateOrder(transactionId)async{
    final updatedOrder = OrdersEntity(
      id: orderProductsEntity.order.id,
      address_id: addressEntity.id!,
      total: orderProductsEntity.order.total,
      items: orderProductsEntity.order.items,
      payment_method: "paypal",
      expected_delivery_time: "Not Assigned",
      payment_transaction_id: transactionId,
      status: "paid",
    );

    final updateResult = await updateOrderUseCase(updatedOrder);
    updateResult.fold(
          (error) => showToastMessage(label: "", text: error),
          (res) {
        showToastMessage(
            label: "", text: AppStrings.paymantSuccessfully.tr);
      },
    );
  }
}


