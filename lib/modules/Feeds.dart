import 'package:flutter/material.dart';
import 'package:social_app/models/postmodel.dart';
import 'package:social_app/modules/new_comment.dart';
import 'package:social_app/modules/new_post.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class feeds_screen extends StatelessWidget {
  const feeds_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Social_Cubit, Social_States>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(side: BorderSide(width: 2, color: color1)),
            onPressed: () {
              navigateto(context, New_Post());
            },
            child: Icon(
              Icons.post_add,
              color: color2,
            ),
          ),
          body: ConditionalBuilder(
              condition: Social_Cubit.get(context).posts.length > 0 &&
                  Social_Cubit.get(context).model != null,
              builder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          margin: EdgeInsets.all(8),
                          child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image(
                                  image: NetworkImage(
                                      'https://img.freepik.com/free-photo/beautiful-portrait-teenager-woman_23-2149453395.jpg?w=826&t=st=1699709328~exp=1699709928~hmac=bb46e820928f9c5954a9a55fc5316a3d80deaf09bf036a82092ec9e5a2d06bdd'),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Hello With us',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ])),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Container(
                          width: double.infinity,
                          height: 10,
                        ),
                        itemBuilder: (context, index) => buildPostItem(
                            Social_Cubit.get(context).posts[index],
                            context,
                            index),
                        itemCount: Social_Cubit.get(context).posts.length,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        );
      },
    );
  }

  Widget buildPostItem(Postmodel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(height: 1.6),
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
                    Text(
                      '${model.datetime}',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(height: 1.6),
                    )
                  ],
                )),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 15,
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: color2.withOpacity(.4),
              ),
            ),
            Text(
              '${model.text}',
              style: TextStyle(height: 1.4, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(end: 6),
                      height: 25,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1,
                        child: Text(
                          '#Software ',
                          style: TextStyle(color: Colors.blue),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postimage != "")
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: NetworkImage('${model.postimage}'),
                      fit: BoxFit.cover),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${Social_Cubit.get(context).likes[index]}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.comment,
                              color: color2,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0 comments',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: color2.withOpacity(.4),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Social_Cubit.get(context).getpostid(
                        //     Social_Cubit.get(context).posts_id[index]);
                        Social_Cubit.get(context).getcomments(
                            Social_Cubit.get(context).posts_id[index]);
                        Social_Cubit.get(context).comment_count(
                            Social_Cubit.get(context).posts_id[index]);
                        navigateto(
                            context,
                            CommentScreen(
                              index: index,
                            ));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                '${Social_Cubit.get(context).model?.image}'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('write a comment ...')
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Social_Cubit.get(context)
                          .likepost(Social_Cubit.get(context).posts_id[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
}
