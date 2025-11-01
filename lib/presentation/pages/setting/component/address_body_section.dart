import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/setting/address_controller.dart';
import 'address_listview.dart';
class AddressBodySection extends StatelessWidget {
  const AddressBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
        builder: (_) => const AddressListview());
  }
}
