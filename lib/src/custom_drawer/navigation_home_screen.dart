import 'dart:async';

import 'package:cuyuyu/src/pages/about_page.dart';
import 'package:cuyuyu/src/pages/favorite_page.dart';
import 'package:cuyuyu/src/pages/home_screen.dart';
import 'package:cuyuyu/src/pages/map_page.dart';
import 'package:cuyuyu/src/pages/request_page.dart';
import 'package:cuyuyu/src/pages/settings_page.dart';
import 'package:cuyuyu/src/pages/support_page.dart';
import 'package:cuyuyu/src/users/login_page.dart';
import 'package:cuyuyu/src/users/profile_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'custom_drawer.dart';
import 'drawer_user_controller.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = MyHomeScreen();
    _streamSubscription = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high, distanceFilter: 20)
        .listen((Position position) {
      setState(() {
        print(position);
        _position = position;
        final coordinates = Coordinates(position.latitude, position.longitude);
        convertCoordinateToAddress(coordinates)
            .then((value) => _address = value);
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address> convertCoordinateToAddress(Coordinates coordinates) async {
    var address =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = MyHomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.MAP) {
        setState(() {
          screenView = MapPage();
        });
      } else if (drawerIndex == DrawerIndex.SHOPPING) {
        setState(() {
          screenView = RequestPage();
        });
      } else if (drawerIndex == DrawerIndex.FAVORITE) {
        setState(() {
          screenView = FavoritePage();
        });
      } else if (drawerIndex == DrawerIndex.SETTINGS) {
        setState(() {
          screenView = SettingsPage();
        });
      } else if (drawerIndex == DrawerIndex.SUPPORT) {
        setState(() {
          screenView = SupportPage();
        });
      } else if (drawerIndex == DrawerIndex.PROFILE) {
        setState(() {
          screenView = ProfilePage();
        });
      } else if (drawerIndex == DrawerIndex.LOGIN) {
        setState(() {
          screenView = LoginPage();
        });
      } else if (drawerIndex == DrawerIndex.ABOUT) {
        setState(() {
          screenView = AboutPage();
        });
      } else {
        //do in your way......
      }
    }
  }
}