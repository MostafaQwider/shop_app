import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/use_cases/address/add_address_usecase.dart';
import '../../../domain/use_cases/address/update_address_usecase.dart';
import '../../component/app_snack_bar.dart';

class OptionAddressController extends GetxController {
  AddAddressUseCase addAddressUseCase;
  UpdateAddressUseCase updateAddressUseCase;

  OptionAddressController(this.updateAddressUseCase, this.addAddressUseCase);

  final buildingNum = TextEditingController();
  final additional = TextEditingController();
  final floor = TextEditingController();
  final street = TextEditingController();
  final phone = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final companyName = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.initial;
  String type = "add";
  AddressEntity? addressEntity;
  int addressType = 0;
  List<String> types = [AppStrings.apartment.tr, AppStrings.house.tr, AppStrings.office.tr];
  final typesIcons= [
    Icons.apartment,
    Icons.house,
    Icons.local_post_office_outlined
  ];
  final hint = [
    AppStrings.buildingNum.tr,
    AppStrings.houseNum.tr,
    AppStrings.companyNum.tr
  ];

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
    if (type == 'update') setData();
  }

  void setData() {
    addressEntity = Get.arguments['address'];
    addressType=addressEntity!.addressType==AppStrings.apartment.tr?0:
    addressEntity!.addressType==AppStrings.house.tr?1:2;
    buildingNum.text = addressEntity!.addressType==AppStrings.apartment.tr
        ?addressEntity!.buildingNumber.toString():
    addressEntity!.addressType==AppStrings.house.tr?
    addressEntity!.houseNumber.toString():
    addressEntity!.companyNumber.toString();

    additional.text = addressEntity?.additionalDirections.toString()??"";
    floor.text = addressEntity?.floor.toString()??"";
    street.text = addressEntity?.streetName.toString()??"";
    phone.text = addressEntity?.phoneNumber.toString()??"";
    companyName.text = addressEntity!.companyName ?? "";
    city.text = addressEntity!.city ;
    country.text = addressEntity!.country;
  }

  void onAddressTypeChange(index) {
    addressType = index;
    update();
  }

  Future<void> updateAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var editedAddress = AddressEntity(
        id: addressEntity!.id,
        streetName: street.text,
        phoneNumber: phone.text,
        country: country.text,
        city: city.text,
        addressType: types[addressType],
        additionalDirections: additional.text.toString(),
        buildingNumber: addressType == 0 ? int.parse(buildingNum.text) : null,
        companyNumber: addressType == 2 ? int.parse(buildingNum.text) : null,
        houseNumber: addressType == 1 ? int.parse(buildingNum.text) : null,
        floor: addressType != 1 ? int.parse(floor.text):null,
        companyName: addressType == 2 ? companyName.text : null);
    var result = await updateAddressUseCase(editedAddress);
    result.fold((error) => showToastMessage(label: "", text: error),
        (success) => showToastMessage(label: "", text: success.message ?? ""));
    statusRequest=StatusRequest.initial;
    update();
  }
  Future<void> addAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var addedAddress = AddressEntity(
        streetName: street.text,
        phoneNumber: phone.text,
        country: country.text,
        city: city.text,
        addressType: types[addressType],
        additionalDirections: additional.text ,
        buildingNumber: addressType == 0 ? int.parse(buildingNum.text) : null,
        companyNumber: addressType == 2 ? int.parse(buildingNum.text) : null,
        houseNumber: addressType == 1 ? int.parse(buildingNum.text) : null,
        floor: int.parse(floor.text),
        companyName: addressType == 2 ? companyName.text  : null);
    var result = await addAddressUseCase(addedAddress);
    result.fold((error) => showToastMessage(label: "", text: error),
            (success) => showToastMessage(label: "", text: success.message ?? ""));
    statusRequest=StatusRequest.initial;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    buildingNum.dispose();
    street.dispose();
    phone.dispose();
    additional.dispose();
    country.dispose();
    city.dispose();
    floor.dispose();
    companyName.dispose();
  }
}
