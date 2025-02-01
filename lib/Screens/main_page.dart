import 'package:car_store/Screens/FavoriteCar.dart';
import 'package:car_store/Screens/Profilepage.dart';
import 'package:car_store/widget/Bottom_navBar.dart';
import 'package:car_store/widget/Custom_scroll_View.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String id = 'MainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  int selectindex = 0;

  void navigatebottombar(index) {
    setState(() {
      selectindex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context)!.settings.arguments as String;

      final List<Widget> pages =  [
    Custom_scroll_View(userid: uid,),
    Favoritecar(userid: uid,),
    Profilepage(uid: uid,),
  ];

    return Scaffold(
      bottomNavigationBar:
          BottomNavbar(onchange: (index) => navigatebottombar(index)),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
        child: pages[selectindex],
      ),
    );
  }
}

