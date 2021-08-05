//@dart=2.9
import 'package:cuyuyu/src/pages/favorite_page.dart';
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/pages/map_page.dart';
import 'package:cuyuyu/src/users/profile_page.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    @required Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFF767676);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: SvgPicture.asset("images/icons/home.svg",
                      color: MenuState.home == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor),
                  onPressed: () => Navigator.maybeOf(context).push(MaterialPageRoute(
                      builder: (context) => HomeScreen()))
                  ),
              IconButton(
                icon: SvgPicture.asset("images/icons/pin.svg",
                    color: MenuState.map == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor),
                onPressed: () => Navigator.maybeOf(context).push(MaterialPageRoute(
                    builder: (context) => MapPage())),
              ),
              IconButton(
                icon: SvgPicture.asset("images/icons/favorites.svg",
                    color: MenuState.favorite == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor
                    ),
                onPressed: () => Navigator.maybeOf(context).push(MaterialPageRoute(
                    builder: (context) =>  FavoritePage())),
              ),
              IconButton(
                icon: SvgPicture.asset("images/icons/profile.svg",
                color: MenuState.profile == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor),
                onPressed: () =>
                  Navigator.maybeOf(context).push(MaterialPageRoute(
                      builder: (context) => ProfilePage()))
              ),
            ],
          )),
    );
  }
}
