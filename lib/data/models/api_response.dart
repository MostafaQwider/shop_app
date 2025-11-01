import '../../core/constants/enums.dart';

class ApiResponse<T>{
  final StatusRequest status;
  final String? message;
  final T? data;

  ApiResponse({
    required this.status,
    this.message,
    this.data,
  });
}
