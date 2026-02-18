import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  String get message;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final String _message;
  const ServerFailure([this._message = 'Server Failure']);

  @override
  String get message => _message;
}

class CacheFailure extends Failure {
  final String _message;
  const CacheFailure([this._message = 'Cache Failure']);

  @override
  String get message => _message;
}
