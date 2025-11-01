import 'package:flutter/material.dart';
import '../../../../domain/entities/order_products_entity.dart';
import 'order_item_card.dart';

class OrderItemList extends StatelessWidget {
  const OrderItemList({super.key, required this.items});

  final List<ProductWithQuantityEntity> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) => OrderItemCard(product: items[index]),
    );
  }
}
