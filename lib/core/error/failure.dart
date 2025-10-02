/*import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class UnAuthenticatedFailure extends Failure {
  const UnAuthenticatedFailure(super.message);
}*/
// core/error/failure.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure { // إضافة CacheFailure
  const CacheFailure() : super('فشل في التخزين المؤقت');
}

class UnAuthenticatedFailure extends Failure {
  const UnAuthenticatedFailure(super.message);
}

class NetworkFailure extends Failure { // يمكن إضافتها أيضاً إذا احتجتها
  const NetworkFailure() : super('فشل في الاتصال بالشبكة');
}
