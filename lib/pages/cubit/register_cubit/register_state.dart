part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterFailed extends RegisterState {
  String errorMsg;
  RegisterFailed({required this.errorMsg});
}
