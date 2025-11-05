class PaymentConfigEntity {
  String secretKey;
  String clientId;
  String mode;

  PaymentConfigEntity(
      {required this.secretKey, required this.clientId, required this.mode});
}
