import 'package:dio/dio.dart';
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/core/services/dependency_injection/locator.dart';
import 'package:kanban/core/services/network/network_info.dart';

abstract class DioErrorHandler {
  Failure resolveErrors({required Response<dynamic> response});

  Failure throwDefaultFailure();
  Failure handleCancelRequestFailure();
}

class DioErrorHandlerImpl extends DioErrorHandler {
  @override
  Failure resolveErrors({required Response<dynamic> response}) {
    switch (response.statusCode) {
      case 500:
        return const DioInternalError(message: 'Internal Error');

      case 404:
        return const DioNotFoundError(
          message: 'Not Found',
        );
      case 204:
        return const DioContentNotFound(message: 'Something went wrong');
      case 401:
        return const DioUnAuthorized(message: 'Not Authorized');
      case 409:
        return const ResultsNotFound(message: 'Server Error');
      case 422:
        return const ResultsNotFound(message: 'No Results Found');
      case 503:
        return const ServiceUnavailableFailure(message: 'Not Authorized');
      case 599:
        return const DioTimeoutError(message: 'Request Timeout');
      case 400:
        return const DioBadRequest(message: 'Bad Request');
      default:
        return const DioDefaultFailure(message: 'Something went wrong');
    }
  }

  @override
  Failure throwDefaultFailure() {
    if (isConnected()) {
      return const DioDefaultFailure(message: 'Something went wrong');
    } else {
      return const DioDefaultFailure(message: 'No Internet Connection');
    }
  }

  @override
  DioCancleRequest handleCancelRequestFailure() {
    return const DioCancleRequest(message: 'Request Cancelled');
  }

  bool isConnected() {
    var isConnected = false;
    final networkInfo = locator<INetworkInfo>();
    networkInfo.isConnected.then((value) {
      isConnected = value;
    });
    return isConnected;
  }
}
