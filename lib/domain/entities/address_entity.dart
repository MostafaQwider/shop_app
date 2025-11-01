class AddressEntity {
  final int? id;
  final String streetName;
  final String? additionalDirections;
  final String phoneNumber;
  final String addressType;
  final String city;
  final String country;
  final int? buildingNumber;
  final int? floor;
  final int? houseNumber;
  final int? companyNumber;
  final String? companyName;

  AddressEntity({
    this.id,
    required this.streetName,
    this.additionalDirections,
    required this.phoneNumber,
    required this.addressType,
    required this.country,
    required this.city,
    this.buildingNumber,
    this.floor,
    this.houseNumber,
    this.companyNumber,
    this.companyName,
  });

  AddressEntity copyWith({
    int? id,
    String? streetName,
    String? additionalDirections,
    String? phoneNumber,
    String? addressType,
    int? buildingNumber,
    int? floor,
    int? houseNumber,
    int? companyNumber,
    String? companyName,
    String? country,
    String? city,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      streetName: streetName ?? this.streetName,
      additionalDirections: additionalDirections ?? this.additionalDirections,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressType: addressType ?? this.addressType,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      floor: floor ?? this.floor,
      houseNumber: houseNumber ?? this.houseNumber,
      companyNumber: companyNumber ?? this.companyNumber,
      companyName: companyName ?? this.companyName,
      country: country ??this.country,
      city: city ?? this.city,
    );
  }
}
