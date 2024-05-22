import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:social_app/cache/cache.dart';
import 'package:social_app/layout/home_page.dart';
import 'package:social_app/modules/Register/cubit/cubit_register.dart';
import 'package:social_app/modules/Register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is registercreateSuccessState) {
            navigatet_close(context, home());
          }
            if (state is registercreateErrorState) {
            Fluttertoast.showToast(msg: state.error);
          }
          if (state is registercreateSuccessState) {
            Cache_Helper.savedata(key: 'uid', value: state.uid).then((value) {
              navigatet_close(context, home());
              
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  color: const Color.fromARGB(255, 175, 163, 163),
                ),
                Center(
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 30),
                        child: Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Register ',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              defaulttextfield(
                                  controller: namecontroller,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'name must not be null';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  label: 'Name',
                                  prefix: Icons.person),
                              SizedBox(
                                height: 20,
                              ),
                              defaulttextfield(
                                  controller: phonecontroller,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'phone must not be null';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  label: 'Phone',
                                  prefix: Icons.phone),
                              SizedBox(
                                height: 20,
                              ),
                              defaulttextfield(
                                  controller: emailcontroller,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'email must not be null';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  label: 'Email Addreess',
                                  prefix: Icons.email),
                              SizedBox(
                                height: 20,
                              ),
                              defaulttextfield(
                                  controller: passwordcontroller,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'password must not be null';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  label: 'Password',
                                  onSubmit: (value) {
                                    if (formkey.currentState!.validate()) {
                                      RegisterCubit.get(context).Register_user(
                                          name: namecontroller.text,
                                          phone: phonecontroller.text,
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text);
                                    }
                                  },
                                  prefix: Icons.password),
                              SizedBox(
                                height: 20,
                              ),
                              ConditionalBuilder(
                                condition: state is! registerLoadState,
                                builder: (context) => defaultbutton(
                                    w: 120,
                                    onpress: () {
                                      if (formkey.currentState!.validate()) {
                                        RegisterCubit.get(context)
                                            .Register_user(
                                                name: namecontroller.text,
                                                phone: phonecontroller.text,
                                                email: emailcontroller.text,
                                                password:
                                                    passwordcontroller.text);
                                      }
                                    },
                                    text: 'register'),
                                fallback: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              defaultbutton(
                                  text: 'Login',
                                  onpress: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
