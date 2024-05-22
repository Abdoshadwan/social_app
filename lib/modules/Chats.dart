import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/modules/Chat.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:social_app/shared/components/components.dart';

class chat_screen extends StatelessWidget {
  const chat_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Social_Cubit, Social_States>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
              condition: Social_Cubit.get(context).allusers.length > 0,
              builder: (context) {
                return ListView.separated(
                    itemBuilder: (context, index) => chatBuilder(
                        context, Social_Cubit.get(context).allusers[index]),
                    separatorBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        color: Colors.grey,
                        height: 0.2,
                      );
                    },
                    itemCount: Social_Cubit.get(context).allusers.length);
              },
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ));
  }
}

Widget chatBuilder(context, UserModel model) => InkWell(
      onTap: () {
        navigateto(context, Chat(model: model));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage('${model.image}'),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${model.name}',
                                style: TextStyle(
                                    height: 1.6,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
