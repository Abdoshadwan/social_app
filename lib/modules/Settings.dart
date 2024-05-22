import 'package:flutter/material.dart';
import 'package:social_app/modules/edit_profile.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class settings_screen extends StatelessWidget {
  const settings_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Social_Cubit, Social_States>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = Social_Cubit.get(context).model;
        return ConditionalBuilder(
          condition: state is GetUserSuccessState,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 195,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4)),
                              image: DecorationImage(
                                  image: NetworkImage('${usermodel?.cover}'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          radius: 64,
                          child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage('${usermodel?.image}')),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${usermodel?.name}',
                    style: TextStyle(fontFamily: 'Oswald'),
                  ),
                  Text('${usermodel?.bio}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: TextStyle(fontFamily: 'Oswald'),
                                ),
                                Text('Posts'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '40',
                                  style: TextStyle(fontFamily: 'Oswald'),
                                ),
                                Text('Photos'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '10K',
                                  style: TextStyle(fontFamily: 'Oswald'),
                                ),
                                Text('Followers'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '70',
                                  style: TextStyle(fontFamily: 'Oswald'),
                                ),
                                Text('Followings'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: defaultbutton(
                        onpress: () {},
                        text: 'Edit Profile',
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            navigateto(context, edit_profile());
                          },
                          icon: Icon(Icons.edit))
                    ],
                  )
                ],
              ),
            );
          },
          fallback: (context) {
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
