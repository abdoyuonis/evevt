import 'package:flutter/material.dart';
import 'package:untitled15/ui/Home/taps/Home_Tap/Home_Tap.dart';
import 'package:untitled15/ui/Home/taps/Love_Tap/Love_Tap.dart';
import 'package:untitled15/ui/Home/taps/Map_Tap/Map_Tap.dart';
import 'package:untitled15/ui/Home/taps/profile/profile_Tap.dart';
import 'package:untitled15/utils/App_Color.dart';
import 'package:untitled15/utils/App_Images.dart';

import '../taps/Home_Tap/Add_Event.dart';
import '../taps/Home_Tap/Add_Events.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName= 'Home_Screen';
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    List<Widget> taps= [HomeTap(),MapTap(),LoveTap(),ProfileTap(),];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          selectedIndex=value;
          setState(() {

          });
        },
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.white,
       unselectedItemColor: AppColors.white,
       selectedIconTheme: IconThemeData(color: AppColors.white),
       type: BottomNavigationBarType.fixed,
          items: [
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.homeIcon),color: AppColors.white,),label: 'Home'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.mapIcon),color: AppColors.white,),label: 'Map'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.heartIcon),color: AppColors.white,),label: 'Love'),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.profileIcon),color: AppColors.white,),label: 'Profile'),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEvents.routeName);
        },
        child: Icon(Icons.add,color: AppColors.white,size: 30,),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            width: 4,
            color: AppColors.white
          )
        )
        ,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: taps[selectedIndex],
    );
  }
}
