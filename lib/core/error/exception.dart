
import '../network/error_message.dart';

class ServerException implements Exception{
  final ErrorMessageModel errorMessageModel;
  const ServerException({required this.errorMessageModel});
}