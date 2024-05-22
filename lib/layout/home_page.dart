import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cache/cache.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:animations/animations.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Social_Cubit, Social_States>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Social_Cubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News Feed',
              style: TextStyle(color: color2, fontFamily: 'Oswald'),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Cache_Helper.removesaved(key: 'uid');
                  },
                  icon: Icon(Icons.notifications_active_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          ),
          body: PageTransitionSwitcher(
              duration: Duration(seconds: 1),
              transitionBuilder:
                  (child, primaryAnimation, secondaryAnimation) =>
                      FadeThroughTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      ),
              child: cubit.screens[cubit.currentindex]),
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            backgroundColor: color1,
            animationCurve: Curves.ease,
            animationDuration: Duration(milliseconds: 500),
            items: [
              Column(
                children: [
                  Icon(
                    Icons.featured_play_list_rounded,
                    color: color2,
                  ),
                  Text(
                    'Feeds',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.chat,
                    color: color2,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.person,
                    color: color2,
                  ),
                  Text(
                    'Users',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: color2,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                    ),
                  )
                ],
              ),
            ],
            onTap: (index) {
              cubit.CgScreens(index);
              cubit.getuserdata();
              if (index == 0) cubit.getposts();
            },
          ),
        );
      },
    );
  }
}
