import 'package:get/get.dart';

import '../../core/constants/enums.dart';
import '../../core/services/api_service.dart';
import '../models/api_response.dart';
import '../../core/constants/app_api.dart';
import '../models/payment_config_model.dart';

abstract class PaymentConfigRemoteDateSource {
  Future<ApiResponse<PaymentConfigModel>> getConfig();
}

class PaymentConfigRemoteDateSourceImpl
    implements PaymentConfigRemoteDateSource {
  final ApiService _apiService = ApiService();

  @override
  Future<ApiResponse<PaymentConfigModel>> getConfig() async {
    try {
      final decodedJson = await _apiService.get(AppApi.paymentConfig);

      if (decodedJson is Map<String, dynamic>) {
        final  data = decodedJson['data'];

        return ApiResponse<PaymentConfigModel>(
          status: decodedJson['success'] == true
              ? StatusRequest.success
              : StatusRequest.failure,
          message: decodedJson['message'].toString().tr,
          data: PaymentConfigModel.fromJson(data),
        );
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      rethrow;
    }
  }
}
