
import '../../data/models/api_response.dart';
import '../../domain/entities/payment_config_entity.dart';
import '../../domain/repositories/payment_config_repository.dart';
import '../data_sources/payment_config_remote_datasource.dart';

class PaymentConfigRepositoryImpl implements PaymentConfigRepository {
  PaymentConfigRemoteDateSource remoteDateSource;

  PaymentConfigRepositoryImpl(this.remoteDateSource);

  @override
  Future<ApiResponse<PaymentConfigEntity>> getConfig() async {
    final responseModel = await remoteDateSource.getConfig();
    if (responseModel.data != null) {
      return ApiResponse<PaymentConfigEntity>(
        status: responseModel.status,
        data: responseModel.data!.toEntity(),
        message: responseModel.message,
      );
    } else {
      return ApiResponse<PaymentConfigEntity>(
        status: responseModel.status,
        message: responseModel.message,
      );
    }
  }
}
