import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/commentsmodel.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

// ignore: must_be_immutable
class CommentScreen extends StatelessWidget {
  CommentScreen({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    var commentcontroller = TextEditingController();
    var scaffoldkey = GlobalKey<ScaffoldState>();
    return BlocConsumer<Social_Cubit, Social_States>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldkey,
          body: ConditionalBuilder(
            condition: Social_Cubit.get(context).comments.length > 0,
            builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return commentbuilder(
                            Social_Cubit.get(context).comments[index], context);
                      },
                      itemCount: Social_Cubit.get(context).comm_count.length,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, bottom: 8),
                          child: TextFormField(
                            maxLines: 4,
                            minLines: 1,
                            controller: commentcontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'write your comment ',
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            var now = DateTime.now();
                            Social_Cubit.get(context).Createcomment(
                                datetime: now.toString(),
                                postid:
                                    Social_Cubit.get(context).posts_id[index],
                                comment: commentcontroller.text,
                                image: Social_Cubit.get(context)
                                    .comments[index]
                                    .image);

                            commentcontroller = TextEditingController();
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                ]),
            fallback: (context) =>
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                  child: Center(
                child: Text('No Comments'),
              )),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 8),
                      child: TextFormField(
                        maxLines: 4,
                        minLines: 1,
                        controller: commentcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'write your comment ',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        var now = DateTime.now();
                        Social_Cubit.get(context).Createcomment(
                            datetime: now.toString(),
                            postid: Social_Cubit.get(context).posts_id[index],
                            comment: commentcontroller.text,
                            image: Social_Cubit.get(context)
                                .comments[index]
                                .image);

                        commentcontroller = TextEditingController();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}

Widget commentbuilder(Commentmodel model, context) => Stack(
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
                    backgroundImage: NetworkImage(
                        '${Social_Cubit.get(context).model!.image}'),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Color.fromRGBO(122, 122, 122, .1),
                ),
                constraints: BoxConstraints(
                  minWidth: 160,
                  maxWidth: 380,
                ),
                child: Row(
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
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 240),
                          child: Text(
                            model.comment,
                            overflow: TextOverflow.fade,
                            maxLines: 4,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
