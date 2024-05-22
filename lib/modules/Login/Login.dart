import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cache/cache.dart';
import 'package:social_app/layout/home_page.dart';
import 'package:social_app/modules/Login/cubit/cubit_login.dart';
import 'package:social_app/modules/Login/cubit/states.dart';
import 'package:social_app/modules/Register/Register.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            Fluttertoast.showToast(msg: state.error);
          }
          if (state is LoginSuccessState) {
            Cache_Helper.savedata(key: 'uid', value: state.uid).then((value) {
              navigatet_close(context, home());
            });
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'login now ',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      defaulttextfield(
                          controller: emailcontroller,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter email address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          label: 'Email Address',
                          prefix: Icons.email),
                      SizedBox(
                        height: 50,
                      ),
                      defaulttextfield(
                        obscure: LoginCubit.get(context).issecure,
                        controller: passwordcontroller,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        label: 'Password',
                        prefix: Icons.lock_outline_rounded,
                        suffix: LoginCubit.get(context).suffix,
                        ontp: () {
                          LoginCubit.get(context).changesuffix();
                        },
                        onSubmit: (value) {
                          if (formkey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailcontroller.text,
                                password: passwordcontroller.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => defaultbutton(
                                  onpress: () {
                                    if (formkey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text);
                                    }
                                  },
                                  text: 'login'),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            )
                          ]),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? '),
                          TextButton(
                              onPressed: () {
                                navigateto(context, Register());
                              },
                              child: Text('Register'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
