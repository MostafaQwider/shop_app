import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/favorite/favorite_page.dart';
import '../pages/home/home_page.dart';
import '../pages/order/order_page.dart';
import '../pages/setting/settings_page.dart';
// ---------------- Controller ----------------
class MainScreenController extends GetxController {
  final _index = 0.obs;

  int get index => _index.value;

  set index(int i) => _index.value = i;

  final List<Widget> pages = [
    const HomePage(),
    const FavoritePage(),
    const CartPage(),
    const OrderPage(),
    const SettingsPage(),
  ];
}
