import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({required String email,required String password}) async {
    emit(RegisterLoading());
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailed(errorMsg: 'weak-password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailed(errorMsg: 'email already in use'));
      }
    } on Exception catch (e) {
      emit(RegisterFailed(errorMsg: '${e.toString()}'));
    }
  }
}
