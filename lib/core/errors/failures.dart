import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);
  final String message;
}

class CommonFailure extends Failure {
  const CommonFailure(super.message);

  @override
  List<Object?> get props => [];
}

Failure handleFailure(Either<Failure, dynamic> resultEither) {
  return resultEither.fold((failure) => failure, (r) => null)!;
}

class DioInternalError extends Failure {
  const DioInternalError({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioNotFoundError extends Failure {
  const DioNotFoundError({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioContentNotFound extends Failure {
  const DioContentNotFound({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioBadRequest extends Failure {
  const DioBadRequest({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioUnAuthorized extends Failure {
  const DioUnAuthorized({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class ResultsNotFound extends Failure {
  const ResultsNotFound({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioDefaultFailure extends Failure {
  const DioDefaultFailure({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure(super.message, this.title);
  final String title;

  @override
  List<Object?> get props => [message, title];
}

class ApiCancelled extends Failure {
  const ApiCancelled(super.message);

  @override
  List<Object?> get props => [message];
}

class DioTimeoutError extends Failure {
  const DioTimeoutError({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioCancleRequest extends Failure {
  const DioCancleRequest({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}
