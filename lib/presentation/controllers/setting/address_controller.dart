import 'package:get/get.dart';

import '../../../core/constants/enums.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/use_cases/address/get_address_usecase.dart';
import '../../../domain/use_cases/address/remove_address_usecase.dart';
import '../../component/app_snack_bar.dart';

class AddressController extends GetxController {
  RemoveAddressUseCase removeAddressUseCase;
  GetAddressUseCase getAddressUseCase;

  AddressController(this.getAddressUseCase, this.removeAddressUseCase);

  StatusRequest statusRequest = StatusRequest.loading;
  List<AddressEntity> addresses = [];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    addresses.clear();
    final result = await getAddressUseCase();
    result.fold((error) => showToastMessage(label: "", text: error),
        (data) => addresses.addAll(data.data!));

    statusRequest = StatusRequest.initial;
    checkData();
    update();
  }

  Future<void> removeAddress(AddressEntity item) async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await removeAddressUseCase(item);
    result.fold((error) => showToastMessage(label: "", text: error), (data) {
      showToastMessage(label: "", text: data.message ?? "");
      addresses.removeWhere((element) => element.id==item.id);
    });

    statusRequest = StatusRequest.initial;
    checkData();
    update();
  }
  void checkData(){
    if(addresses.isEmpty)
      statusRequest=StatusRequest.nodata;
  }
}
