import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/strings.dart';
import '../../component/app_button.dart';
import '../../component/app_dialog.dart';
import '../../component/handling_data.dart';
import '../../controllers/main_screen_pages/cart_controller.dart';
import '../../routes/app_routes.dart';
import 'component/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) => HandlingData(
        statusRequest: controller.statusRequest,
        child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () => controller.loadCart(),
                child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.cartProducts.length,
                        itemBuilder: (context, index) => CartItemCard(
                            product: controller.cartProducts[index],
                            quantity: controller
                                .getQuantity(controller.cartProducts[index])),
                      ),
                    ]),
              ),
            ),

        ),
        bottomNavigationBar: Container(
          height: Get.height / 5,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              children: [
                GetBuilder<CartController>(
                  builder: (_) => Text(
                    "${controller.totalPrice.toStringAsFixed(2)} \$",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: AppButton(
                    text: AppStrings.checkout.tr,
                    onPressed: () async{
                      if(!await controller.isGuest()){
                            Get.toNamed(AppRoutes.checkoutRoute, arguments: {
                              "product": controller.cartProducts,
                              "cartItems": controller.cartItems,
                              "subTotal": controller.totalPrice
                            });}
                      else{
                        Get.dialog(
                          AppDialog(
                            message: AppStrings.guestCheckoutLoginRequired.tr,
                            cancelText: AppStrings.cancel.tr,
                            confirmText: AppStrings.login.tr,
                            onCancel: () => Get.back(),
                            onConfirm: () {
                              Get.back();
                              Get.offAllNamed(AppRoutes.loginRoute);
                            },
                          ),
                          barrierDismissible: false,
                        );
                      }
                          }),
                ),
              ],
            ),
          ),
            )),
      ),
    );
  }
}
