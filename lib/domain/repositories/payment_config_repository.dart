
import '../../data/models/api_response.dart';
import '../entities/payment_config_entity.dart';

abstract class PaymentConfigRepository {
  Future<ApiResponse<PaymentConfigEntity>> getConfig();
}
