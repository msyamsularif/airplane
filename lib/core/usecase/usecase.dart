import 'package:airplane/core/values/values.dart';

abstract class UseCase<Type, Params> {
  Future<ApiReturnValue> call(Params params);
}