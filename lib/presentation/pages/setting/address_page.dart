import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/handling_data.dart';
import '../../controllers/setting/address_controller.dart';
import 'component/address_body_section.dart';
import 'component/custom_address_appbar.dart';
class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAddressAppbar(),
      body: SafeArea(
          child: GetBuilder<AddressController>(
        builder: (controller) => RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () => controller.loadData(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(), // مهم
            children: [
              HandlingData(
                statusRequest: controller.statusRequest,
                child: const AddressBodySection(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
