import 'package:kanban/core/models/api_error_model.dart';

abstract class ApiResponseModel {
  ApiResponseModel({
    required this.success,
    required this.serverTime,
    required this.error,
  });

  final bool success;
  final int serverTime;
  final ErrorModel error;
}
