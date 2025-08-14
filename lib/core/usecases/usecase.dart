// 🎯 Base Use Case
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class Params {
  final Map<String, dynamic> data;
  
  Params(this.data);
  
  T? get<T>(String key) => data[key] as T?;
  
  void set<T>(String key, T value) => data[key] = value;
}
