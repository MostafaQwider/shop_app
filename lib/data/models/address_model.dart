import '../../domain/entities/address_entity.dart';

class AddressModel {
  final AddressEntity entity;

  AddressModel({required this.entity});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      entity: AddressEntity(
        id: json['id'],
        streetName: json['street_name'],
        additionalDirections: json['additional_directions'],
        phoneNumber: json['phone_number'],
        addressType: json['address_type'],
        buildingNumber: json['building_number'],
        floor: json['floor'],
        houseNumber: json['house_number'],
        companyNumber: json['company_number'],
        companyName: json['company_name'],
        city: json['city'],
        country: json['country'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'street_name': entity.streetName,
      'additional_directions': entity.additionalDirections,
      'phone_number': entity.phoneNumber,
      'address_type': entity.addressType,
      'building_number': entity.buildingNumber,
      'floor': entity.floor,
      'house_number': entity.houseNumber,
      'company_number': entity.companyNumber,
      'company_name': entity.companyName,
      'country': entity.country,
      'city': entity.city,
    };
  }

  AddressEntity toEntity() => entity;

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(entity: entity);
  }
}
