
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatefulWidget {
  BottomNavbar({super.key,required this.onchange});

  final Function(int) onchange;
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: GNav(
            onTabChange: (value)=>widget.onchange(value),
            backgroundColor: Colors.black,
            color: Colors.grey,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            activeColor: Colors.white,
            tabBorderRadius: 24,
            tabs:const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.favorite_border, text: 'Favorite'),
              // GButton(icon: Icons.shopping_bag_outlined, text: 'Cart'),
              GButton(icon: Icons.person, text: 'Profile'),
            ]),
      ),
    );
  }
}
