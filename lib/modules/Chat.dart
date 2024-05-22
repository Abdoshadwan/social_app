import 'package:flutter/material.dart';
import 'package:social_app/models/message.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class Chat extends StatelessWidget {
  Chat({super.key, required this.model});
  final UserModel model;
  final sendmessagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Social_Cubit.get(context).getmessages(recieverid: model.uid);
      return BlocConsumer<Social_Cubit, Social_States>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Row(children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(model.name),
                ]),
              ),
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition:
                            Social_Cubit.get(context).messages.length > 0,
                        builder: (context) => ListView.separated(
                            itemBuilder: (context, index) {
                              var message =
                                  Social_Cubit.get(context).messages[index];
                              if (Social_Cubit.get(context).model?.uid ==
                                  message.senderid)
                                return buildmymessage(message);
                              return buildmessage(message);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount:
                                Social_Cubit.get(context).messages.length),
                        fallback: (context) => Center(
                          child: Text('no messages'),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: .6, color: color1),
                          borderRadius: BorderRadius.circular(5)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: (' write ')),
                              controller: sendmessagecontroller,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: IconButton(
                                onPressed: () {
                                  Social_Cubit.get(context).getsendimage();
                                },
                                icon: Icon(
                                  Icons.attach_file_rounded,
                                  size: 16,
                                  color: color1,
                                )),
                          ),
                          Container(
                            height: 40,
                            child: IconButton(
                                onPressed: () {
                                  Social_Cubit.get(context).sendimage != null
                                      ? Social_Cubit.get(context)
                                          .uploadsendimage(
                                              recieverid: model.uid,
                                              datetime:
                                                  DateTime.now().toString(),
                                              text: sendmessagecontroller.text)
                                      : Social_Cubit.get(context).sendmessage(
                                          recieverid: model.uid,
                                          datetime: DateTime.now().toString(),
                                          text: sendmessagecontroller.text);
                                },
                                icon: Icon(
                                  Icons.send,
                                  size: 16,
                                  color: color1,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
      );
    });
  }
}

Widget buildmessage(Messagemodel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model.text != "")
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: color3,
                    borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        topStart: Radius.circular(10))),
                child: Text(model.text)),
          if (model.image != "")
            Container(
              constraints: BoxConstraints(maxHeight: 150, maxWidth: 300),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage('${model.image}'), fit: BoxFit.fill),
              ),
            )
        ],
      ),
    );
Widget buildmymessage(Messagemodel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (model.text != "")
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: color1.withOpacity(.2),
                    borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        topStart: Radius.circular(10))),
                child: Text(model.text)),
          if (model.image != "")
            Container(
              constraints: BoxConstraints(maxHeight: 150, maxWidth: 200),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.fitHeight),
              ),
            )
        ],
      ),
    );
