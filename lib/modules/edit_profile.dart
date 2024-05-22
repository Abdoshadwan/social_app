import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants/constants.dart';

class edit_profile extends StatelessWidget {
  edit_profile({super.key});
  final namecontroller = TextEditingController();
  final biocontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Social_Cubit, Social_States>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = Social_Cubit.get(context).model;
        var profileimage = Social_Cubit.get(context).profileimage;
        var coverimage = Social_Cubit.get(context).coverImage;
        namecontroller.text = usermodel!.name;
        biocontroller.text = usermodel.bio;
        phonecontroller.text = usermodel.phone;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text('Edit Profile'),
            actions: [
              TextButton(
                  onPressed: () {
                    Social_Cubit.get(context).updatedata(
                        name: namecontroller.text,
                        phone: phonecontroller.text,
                        bio: biocontroller.text);
                   
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 18, color: color2),
                  )),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                if (state is UpdateloadingState)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LinearProgressIndicator(),
                  ),
                Container(
                  height: 195,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
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
                                    image: coverimage == null
                                        ? NetworkImage('${usermodel.cover}')
                                        : FileImage(coverimage)
                                            as ImageProvider,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            IconButton.outlined(
                                color: color2,
                                onPressed: () {
                                  Social_Cubit.get(context).getCoverImage();
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                ))
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 64,
                            child: CircleAvatar(
                                radius: 60,
                                // ignore: unnecessary_null_comparison
                                backgroundImage: profileimage == null
                                    ? NetworkImage('${usermodel.image}')
                                    : FileImage(profileimage) as ImageProvider),
                          ),
                          IconButton.outlined(
                              color: color2,
                              onPressed: () {
                                Social_Cubit.get(context).getProfileImage();
                              },
                              icon: Icon(
                                Icons.camera_alt_outlined,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                defaulttextfield(
                    controller: namecontroller,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'you need enter name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    label: 'Name',
                    prefix: Icons.person_outline),
                SizedBox(
                  height: 20,
                ),
                defaulttextfield(
                    controller: biocontroller,
                    validator: (String? value) {
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    label: 'Bio',
                    prefix: Icons.info_outlined),
                defaulttextfield(
                    controller: phonecontroller,
                    validator: (String? value) {
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    label: 'phone',
                    prefix: Icons.phone)
              ]),
            ),
          ),
        );
      },
    );
  }
}
