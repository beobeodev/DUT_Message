class AppException implements Exception {
  final int? statusCode;
  final String status;
  final String message;

  AppException({this.statusCode, required this.status, required this.message});

  @override
  String toString() {
    return '$status: $message';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(
          statusCode: 500,
          status: 'Error when create connection',
          message: message,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String message)
      : super(
          statusCode: 404,
          status: 'Bad request',
          message: message,
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String message)
      : super(
          statusCode: 401,
          status: 'Unauthorised',
          message: message,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String message)
      : super(
          status: 'Invalid input',
          message: message,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String message)
      : super(status: 'Authentication failed', message: message);
}

class TimeOutException extends AppException {
  TimeOutException(String message)
      : super(status: 'Request timeout', message: message);
}
