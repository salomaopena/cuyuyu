import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/users/login_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/colors.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList> drawerList;
  final user = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userReference;

  @override
  void initState() {
    userReference = user.collection(USER_URL);
    FirebaseAuth.instance.currentUser;
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home, color: cuyuyuOrange),
      ),
      DrawerList(
        index: DrawerIndex.MAP,
        labelName: 'Mapa',
        icon: Icon(Icons.map, color: cuyuyuOrange),
      ),
      DrawerList(
          index: DrawerIndex.SHOPPING,
          labelName: 'Compras',
          icon: Icon(Icons.shopping_basket, color: cuyuyuOrange)),
      DrawerList(
        index: DrawerIndex.FAVORITE,
        labelName: 'Favoritos',
        icon: Icon(Icons.favorite, color: cuyuyuOrange),
      ),
      DrawerList(
        index: DrawerIndex.SETTINGS,
        labelName: 'Definições',
        icon: Icon(Icons.settings, color: cuyuyuOrange),
      ),
      DrawerList(
        index: DrawerIndex.SUPPORT,
        labelName: 'Apoio ao cliente',
        icon: Icon(Icons.help, color: cuyuyuOrange),
      ),
      DrawerList(
        index: DrawerIndex.PROFILE,
        labelName: 'Perfil',
        icon: Icon(Icons.person, color: cuyuyuOrange),
      ),
      DrawerList(
        index: DrawerIndex.ABOUT,
        labelName: 'Sobre...',
        icon: Icon(Icons.info, color: cuyutyuBlue),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: FirebaseAuth.instance.currentUser != null
                              ? FutureBuilder(
                                  future: loadUser(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    var doc = snapshot.data.data();
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: AppTheme.nearlyWhite
                                                      .withOpacity(0.6),
                                                  offset:
                                                      const Offset(1.0, 3.0),
                                                  blurRadius: 0),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(60.0)),
                                            child: Image.asset(
                                              'images/app_logo.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      case ConnectionState.waiting:
                                        return Container(
                                          child: Center(
                                              child:
                                                  new LinearProgressIndicator()),
                                        );
                                      default:
                                        if (!snapshot.hasData) {
                                          return Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: AppTheme.nearlyWhite
                                                        .withOpacity(0.6),
                                                    offset:
                                                        const Offset(1.0, 3.0),
                                                    blurRadius: 0),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(60.0)),
                                              child: Image.asset(
                                                'images/app_logo.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: AppTheme.grey
                                                        .withOpacity(0.6),
                                                    offset:
                                                        const Offset(1.0, 3.0),
                                                    blurRadius: 4),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(60.0)),
                                              child: Image.network(
                                                doc['photoUrl'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }
                                    }
                                  },
                                )
                              : Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: AppTheme.nearlyWhite
                                              .withOpacity(0.6),
                                          offset: const Offset(1.0, 3.0),
                                          blurRadius: 0),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(60.0)),
                                    child: Image.asset(
                                      'images/app_logo.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: FirebaseAuth.instance.currentUser != null
                        ? Container(
                            child: FutureBuilder(
                              future: loadUser(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                var doc = snapshot.data.data();
                                if (!snapshot.hasData) {
                                  return Container(
                                    child: Text(
                                      "Cuyuyu Entregas",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.grey,
                                        fontSize: 17,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text(
                                    doc['userName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.grey,
                                      fontSize: 17,
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        : Container(
                            child: Text(
                              "Cuyuyu Entregas",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.grey,
                                fontSize: 17,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Iniciar sessão',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.green,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<DocumentSnapshot> loadUser() {
    return userReference.doc(auth.currentUser.uid).get();
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  MAP,
  SHOPPING,
  FAVORITE,
  SETTINGS,
  SUPPORT,
  PROFILE,
  LOGIN,
  ABOUT,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
