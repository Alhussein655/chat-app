import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegisterPage extends StatelessWidget {
  @override
  GlobalKey<FormState> formKey = GlobalKey();
  static String id = 'registerpage';

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool isRegisterd = false;

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is RegisterLoading){
            isRegisterd=true;
          }
          else if(state is RegisterSuccess){
            Navigator.pushNamed(context, LoginPage.id);
isRegisterd=false;
          }
          else if(state is RegisterFailed){
            showSnackbar(context, state.errorMsg, Colors.grey);
            isRegisterd=false;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isRegisterd,
            child: Scaffold(
              backgroundColor: Color(0xff2B475E),
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Image.asset('assets/images/chat_logo.png',
                              width: 100, color: Colors.white),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Chat App',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                'register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextFormFiled(
                              pad: 7, hint: 'Email', controller: email),
                          CustomTextFormFiled(
                            pad: 7,
                            isSecure: true,
                            hint: 'Password',
                            controller: password,
                          ),
                          CustomButton(
                            height: 40,
                            width: double.infinity,
                            color: Colors.white,
                            borderR: 6,
                            name: 'register',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerUser(
                                    email: email.text, password: password.text);
                              }
                              else {}
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account !"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'login',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
  }

  Future<UserCredential> registerUser(FirebaseAuth auth) async {
    UserCredential data = await auth.createUserWithEmailAndPassword(
        email: email.text, password: password.text);
    return data;
  }
}
