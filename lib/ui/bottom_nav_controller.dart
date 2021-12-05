import 'package:e_commerce_hndit_individual/const/AppColors.dart';
import 'package:e_commerce_hndit_individual/ui/bottom_nav_pages/favorite.dart';
import 'package:e_commerce_hndit_individual/ui/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_pages/cart.dart';
import 'bottom_nav_pages/home.dart';

class BottomNavController  extends StatefulWidget {


  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages =[Home(),Favorite(),Cart(),Profile()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Ecomerce",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar (
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home ),title: Text("Home"),backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline ),title: Text("Favorite"),backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart ),title: Text("Cart"),backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.person ),title: Text("Profile"),backgroundColor: Colors.white),
        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
