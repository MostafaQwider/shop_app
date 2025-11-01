import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../domain/entities/address_entity.dart';

class AddressOfOrderCard extends StatelessWidget {
  const AddressOfOrderCard({super.key, required this.address});

  final AddressEntity address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        surfaceTintColor: Theme.of(context).cardColor,
        child: ListTile(
          title: Text(
            address.addressType,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            '${address.streetName}, ${address.city}, ${address.country}',
            style: const TextStyle(fontSize: 12, color: AppColor.gray),
          ),
        ),
      ),
    );
  }
}
