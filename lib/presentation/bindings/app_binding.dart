import 'package:get/get.dart';
import '../../data/data_sources/address_remote_datasource.dart';
import '../../data/data_sources/cart_local_data_source.dart';
import '../../data/data_sources/favorite_local_data_source.dart';
import '../../data/data_sources/lang_local_datasource.dart';
import '../../data/data_sources/order_remote_datasource.dart';
import '../../data/data_sources/payment_config_remote_datasource.dart';
import '../../data/repositories/address_repository_impl.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../data/repositories/lang_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/payment_config_repository_impl.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../data/data_sources/auth_remote_datasource.dart';
import '../../data/data_sources/product_local_datasource.dart';
import '../../data/data_sources/home_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/product_local_repository_impl.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/lang_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/payment_config_repository.dart';
import '../../domain/repositories/product_local_repository.dart';
import '../../domain/repositories/home_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // DataSources
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(),fenix: true);
    Get.lazyPut<HomeRemoteDateSource>(() => HomeRemoteDateSourceImpl(),fenix: true);
    Get.lazyPut<ProductLocalDateSource>(() => ProductLocalDateSourceImpl(),fenix: true);
    Get.lazyPut<CartLocalDataSource>(() => CartLocalDataSourceImpl(),fenix: true);
    Get.lazyPut<FavoriteLocalDataSource>(() => FavoriteLocalDataSourceImpl(),fenix: true);
    Get.lazyPut<AddressRemoteDataSource>(() => AddressRemoteDataSourceImpl(),fenix: true);
    Get.lazyPut<OrderRemoteDataSource>(() => OrderRemoteDataSourceImpl(),fenix: true);
    Get.lazyPut<LangLocalDataSource>(() => LangLocalDataSourceImpl(),fenix: true);
    Get.lazyPut<PaymentConfigRemoteDateSource>(() => PaymentConfigRemoteDateSourceImpl(),fenix: true);

    // Repositories (يعتمد كل Repository على DataSource الخاص به)
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<ProductLocalRepository>(() => ProductLocalRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<CartRepository>(() => CartRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<FavoriteRepository>(() => FavoriteRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<AddressRepository>(() => AddressRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<LangRepository>(() => LangRepositoryImpl(Get.find()),fenix: true);
    Get.lazyPut<PaymentConfigRepository>(() => PaymentConfigRepositoryImpl(Get.find()),fenix: true);

  }
}
