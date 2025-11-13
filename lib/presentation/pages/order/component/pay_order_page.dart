import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import '../../../controllers/main_screen_pages/order/order_detail_controller.dart';

class PayOrderPage extends StatelessWidget {
  const PayOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    final int orderId=Get.arguments['orderId'];
    return Scaffold(
      body: Center(
        child: GetBuilder<OrderDetailController>(
          builder: (controller) => PaypalCheckoutView(

            sandboxMode: controller.paymentConfigEntity.mode == 'sandbox',
            clientId: controller.paymentConfigEntity.clientId,
            secretKey: controller.paymentConfigEntity.secretKey,

            transactions: [
              {
                "amount": {
                  "total": controller.orderProductsEntity.order.total,
                  "currency": "USD",

                },
                // "item_list": {
                //   "items": controller.getItems(),
                // },
                "invoice_number": orderId.toString(),

                "description": "Shopingo Order Payment",
              }
            ],
            note: "Thank you for your purchase!",
            onSuccess: (Map params) async {
              Get.back(result: {
                'status': 'success',
                'transactionId': params['data']['id'],
              });
            },
            onError: (error) {
              Get.back(result: {
                'status': 'failure',
                'error': error.toString(),
              });
            },
            onCancel: () {
              Get.back(result: {
                'status': 'cancelled',
              });
            },
          ),
        ),
      ),
    );
  }
}
