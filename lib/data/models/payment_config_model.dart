import '../../domain/entities/payment_config_entity.dart';

class PaymentConfigModel {
  final PaymentConfigEntity entity;

  PaymentConfigModel({required this.entity});

  factory PaymentConfigModel.fromJson(Map<String, dynamic> json) {
    return PaymentConfigModel(
      entity: PaymentConfigEntity(
        secretKey: json['secretKey'],
        clientId: json['clientId'],
        mode: json['mode'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secretKey': entity.secretKey,
      'clientId': entity.clientId,
      'mode': entity.mode,
    };
  }

  factory PaymentConfigModel.fromEntity(PaymentConfigEntity entity) {
    return PaymentConfigModel(entity: entity);
  }

  PaymentConfigEntity toEntity() {
    return entity;
  }
}
