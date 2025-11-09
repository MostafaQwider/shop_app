import 'package:get/get.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/strings.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../../domain/entities/order_products_entity.dart';
import '../../../../domain/entities/orders_entity.dart';
import '../../../../domain/entities/product_variants_entity.dart';
import '../../../../domain/entities/products_entity.dart';
import '../../../../domain/use_cases/address/get_address_usecase.dart';
import '../../../../domain/use_cases/orders/get_orders_usecase.dart';
import '../../../../domain/use_cases/orders/remove_orders_usecase.dart';
import '../../../../domain/use_cases/product/product_local_usecase.dart';
import '../../../component/app_snack_bar.dart';

class OrderController extends GetxController {
  /*
  حالات الطلب:
  pending:    الطلب تم إنشاؤه، بانتظار الدفع أو التأكيد 🕓
  paid:       تم الدفع بنجاح والطلب جاهز للمعالجة 💳
  processing: الطلب قيد التحضير في المستودع ⚙️
  shipped:    تم شحن الطلب وهو في الطريق 📦
  delivered:  تم تسليم الطلب بنجاح ✅
  cancelled:  تم إلغاء الطلب قبل إتمامه ❌
  refunded:   تم استرجاع المبلغ للعميل 💸
  */

  final ProductLocalUseCase productUseCase;
  final GetOrderUseCase orderUseCase;
  final RemoveOrderUseCase removeOrderUseCase;
  final GetAddressUseCase getAddressUseCase;

  OrderController(
    this.orderUseCase,
    this.productUseCase,
    this.getAddressUseCase,
    this.removeOrderUseCase,
  );

  StatusRequest statusRequest = StatusRequest.loading;

  /// النصوص المترجمة لحالات الطلبات الموجودة فقط
  final List<String> orderStatus = [];

  /// الحالات الأصلية (keys) الموجودة فعليًا في الطلبات
  final List<String> orderStatusKeys = [];

  int orderStateSelectedIndex = 0;
  List<OrdersEntity> orders = [];
  List<OrdersEntity> filteredOrder = [];
  List<ProductEntity> products = [];
  List<AddressEntity> address = [];
  bool hasError=false;
  // 🔹 خريطة تربط كل حالة بالمفتاح المقابل في AppStrings
  final Map<String, String> statusKeyMap = {
    'pending': AppStrings.pending,
    'paid': AppStrings.paid,
    'processing': AppStrings.processing,
    'shipped': AppStrings.shipped,
    'delivered': AppStrings.delivered,
    'cancelled': AppStrings.cancelledOrder,
    'refunded': AppStrings.refunded,
  };

  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    statusRequest = StatusRequest.loading;
    update();

    filteredOrder.clear();
    orders.clear();
    products.clear();
    orderStatus.clear();
    orderStatusKeys.clear();

    final productResult = await productUseCase();
    final orderResult = await orderUseCase();
    final addressResult = await getAddressUseCase();

    productResult.fold((l) => hasError=true, (r) => products.addAll(r.data ?? []));
    orderResult.fold((l) => hasError=true, (r) => orders.addAll(r.data ?? []));
    addressResult.fold((l) => hasError=true, (r) => address.addAll(r.data ?? []));

    filteredOrder = List.from(orders);
    checkData();
    // 🟩 استخرج الحالات الموجودة فعلاً من الطلبات
    final existingStatuses = orders.map((e) => e.status).toSet();

    // 🟦 خزّن المفاتيح والنصوص المترجمة فقط للحالات الموجودة
    for (final s in existingStatuses) {
      if (statusKeyMap.containsKey(s)) {
        orderStatusKeys.add(s ?? "");
        orderStatus.add(statusKeyMap[s]!.tr);
      }
    }

    // ✅ ابدأ الفلترة بالحالة الأولى الموجودة فعلياً
    if (orderStatusKeys.isNotEmpty) {
      filterOrder();
    }

    statusRequest = hasError?StatusRequest.failure:filteredOrder.isEmpty?
    StatusRequest.nodata:StatusRequest.initial;

    update();
  }

  OrderProductsEntity getOrderProducts(ordId) {
    List<ProductWithQuantityEntity> orderProducts = [];
    var items = orders.firstWhere((ord) => ord.id == ordId).items;

    for (var i in items) {
      final product = products.firstWhereOrNull((p) => p.id == i.product_id);
      if (product != null) {
        final color = product.variants
            .firstWhereOrNull((v) => v.color.id == i.color_id)
            ?.color;
        final size = product.variants
            .firstWhereOrNull((v) => v.size.id == i.size_id)
            ?.size;

        if (color != null && size != null) {
          ProductVariantsEntity variantsEntity =
              ProductVariantsEntity(id: -1, color: color, size: size, price: 0);

          final p = ProductWithQuantityEntity(
            id: product.id,
            quantity: i.quantity,
            basePrice: product.basePrice,
            createdAt: product.createdAt,
            productName: product.productName,
            productDescription: product.productDescription,
            category: product.category,
            images: product.images,
            variants: [variantsEntity],
          );

          orderProducts.add(p);
        }
      }
    }

    return OrderProductsEntity(
      orderProducts,
      orders.firstWhere((ord) => ord.id == ordId),
    );
  }

  void filterOrder() {
    if (orders.isEmpty || orderStatusKeys.isEmpty) return;
    final selectedStatusKey = orderStatusKeys[orderStateSelectedIndex];
    filteredOrder = orders.where((e) => e.status == selectedStatusKey).toList();
    checkData();
    update();
  }

  void selectStatus(int index) {
    orderStateSelectedIndex = index;
    filterOrder();
  }

  Future<void> removeOrder(OrdersEntity order) async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await removeOrderUseCase(order);
    result.fold(
      (error) => showToastMessage(label: "", text: error),
      (success) {
        showToastMessage(label: '', text: success.message ?? "");
        filteredOrder.removeWhere((element) => element.id == order.id);
      },
    );
    statusRequest = StatusRequest.initial;

    checkData();
    update();
  }

  AddressEntity getAddress(addressId) {
    return address.firstWhere((e) => e.id == addressId);
  }

  void checkData() {
    if (filteredOrder.isEmpty) statusRequest = StatusRequest.nodata;
  }
}
