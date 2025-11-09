import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import '../../controllers/checkout/checkout_controller.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<CheckoutController>(
          builder: (controller) => PaypalCheckoutView(
            sandboxMode: controller.paymentConfigEntity.mode == 'sandbox',
            clientId: controller.paymentConfigEntity.clientId,
            secretKey: controller.paymentConfigEntity.secretKey,
            transactions: [
              {
                "amount": {
                  "total": controller.getPriceTotal().toStringAsFixed(2),
                  "currency": "USD",
                },
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
