import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioExeption(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponce(
            dioException.response!.statusCode!, dioException.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('request to ApiServer was canceld');

      case DioExceptionType.unknown:
        if (dioException.message!.contains("SocketExeption")) {
          return ServerFailure('No Internet Connection');
        } else {
          return ServerFailure('Unexpected Error, Please try again later');
        }

      case DioExceptionType.badCertificate:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection timeout with ApiServer');

      default:
        return ServerFailure('Opps There was an Error, Please try again later');
    }
  }

  factory ServerFailure.fromResponce(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      final message = response['error']?['message'] ?? 'Unknown error occurred';
      return ServerFailure(message);
    } else if (statusCode == 404) {
      return ServerFailure(
          'Your request was not found, Please try again later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error, Please try again later');
    } else {
      return ServerFailure('Oops, there was an error. Please try again later');
    }
  }
  @override
  String toString() => errorMessage;
}
