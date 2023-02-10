import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({required String email, password}) async {
    emit(LoginLoading());
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    }
    on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailed(errorMsg: 'user not found'));

      } else if (ex.code == 'wrong-password') {
        emit(LoginFailed(errorMsg: 'wrong password'));

      }
    }
    on Exception catch (e) {

      emit(LoginFailed(errorMsg: '${e.toString()}'));
    }
  }

}
