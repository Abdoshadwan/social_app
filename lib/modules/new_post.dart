import 'package:flutter/material.dart';
import 'package:social_app/layout/home_page.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class New_Post extends StatelessWidget {
  New_Post({super.key});
  var textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Social_Cubit, Social_States>(
      listener: (context, state) {
        if (state is createpostsuccessState) {
          navigatet_close(context, home());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    var now = DateTime.now();

                    if (Social_Cubit.get(context).postimage == null) {
                      Social_Cubit.get(context).CreatePost(
                          datetime: now.toString(), text: textcontroller.text);
                    } else {
                      Social_Cubit.get(context).uploadpostimage(
                          datetime: now.toString(), text: textcontroller.text);
                    }
                  },
                  child: Text(
                    'post',
                    style: TextStyle(fontSize: 20, color: color1),
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              if (state is createpostloadingState) LinearProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              if (state is createpostsuccessState)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/tall-lighthouse-north-sea-cloudy-sky_181624-49637.jpg?w=826&t=st=1699710675~exp=1699711275~hmac=f9dd09ab53ac31f0942a28e70f435b8e41983cee79cdc1b2ba0ca327377e4cbc'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        'abdo shadwan',
                        style: TextStyle(height: 1.6),
                      ),
                    ),
                  ],
                ),
              Expanded(
                child: TextFormField(
                  controller: textcontroller,
                  decoration: InputDecoration(
                      hintText: 'what is on your mind ?',
                      border: InputBorder.none),
                ),
              ),
              if (Social_Cubit.get(context).postimage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        image: DecorationImage(
                            image:
                                FileImage(Social_Cubit.get(context).postimage!),
                            fit: BoxFit.cover),
                      ),
                    ),
                    IconButton.outlined(
                        color: color2,
                        onPressed: () {
                          Social_Cubit.get(context).removepostimage();
                        },
                        icon: Icon(
                          Icons.close,
                        ))
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Social_Cubit.get(context).getPostimage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo')
                          ],
                        )),
                  ),
                  Expanded(
                    child: TextButton(onPressed: () {}, child: Text('# Tags')),
                  ),
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
