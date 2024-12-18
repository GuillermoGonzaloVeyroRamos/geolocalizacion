import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class ButtomNavbar extends StatelessWidget {
  final index;
  const ButtomNavbar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      height: 50,
      color: Color.fromRGBO(207, 0, 0, 30),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      buttonBackgroundColor: Color.fromRGBO(207, 0, 0, 30),
      items: const [
        Icon(Icons.home, color: Colors.white,),
        Icon(Icons.map_outlined, color: Colors.white),
        Icon(Icons.list, color: Colors.white)
      ],
      onTap: (value) => {
        context.go("/home/$value")
       /*  switch (value) {
          case 0:
          context.go("/home/0");
          case 1:
           context.go("/home/1");
           break;
        } */
      },
    );
  }
}