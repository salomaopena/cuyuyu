import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/produtc_home_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool mapTroggle = false;
  Position currentLocation;
  var currentLocations;
  var clients = [];
  GoogleMapController _controller;

  List<Marker> allMarkers = [];

  PageController _pageController;

  int prevPage;

  @override
  void initState() {
    Geolocator.getCurrentPosition().then((curLocation) {
      setState(() {
        currentLocations = curLocation;
        mapTroggle = true;
        populateClients();
      });
    });
    // TODO: implement initState
    super.initState();
  }

  void populateClients() {
    FirebaseFirestore.instance.collection(SHOP_URL).get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          allMarkers.add(Marker(
              markerId: MarkerId(docs.docs[i]['name_shopping']),
              draggable: false,
              infoWindow: InfoWindow(
                  title: docs.docs[i]['name_shopping'],
                  snippet: docs.docs[i]['address_shop']),
              position: LatLng(double.parse(docs.docs[i]['latitude_shop']),
                  double.parse(docs.docs[i]['longitude_shop']))));
        }
        _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
          ..addListener(_onScroll);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ShopAppTheme.buildLightTheme(),
        child: Container(
          child: Scaffold(
              backgroundColor: AppTheme.white,
              body: Stack(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                      children: [
                        appBar(),
                        Expanded(
                          child: mapTroggle
                              ? GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(-14.9106226, 13.4582876),
                                      zoom: 12.0),
                                  markers: Set.from(allMarkers),
                                  onMapCreated: mapCreated,
                                )
                              : Center(
                                  child: Text('Aguarde...'),
                                ),
                        )
                      ],
                    ),
                  ),
                  mapTroggle
                      ? Positioned(
                          bottom: 20.0,
                          child: Container(
                            height: 250.0,
                            width: MediaQuery.of(context).size.width,
                            child: StreamBuilder(
                              stream: loadAllShop(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Container(
                                      child: Center(
                                          child: new Text(
                                              'Internet fraca. \nPor favar, verifique a sua conexão.')),
                                    );
                                  case ConnectionState.waiting:
                                    return Container(
                                      child: Center(
                                          child:
                                              new CircularProgressIndicator()),
                                    );
                                  default:
                                    if (snapshot.hasError) {
                                      return Container(
                                        child: Center(
                                          child: new Text(
                                              'Erro : ${snapshot.error}'),
                                        ),
                                      );
                                    } else if (!snapshot.hasData) {
                                      return Center(
                                        child: Text('Sem dados'),
                                      );
                                    } else {
                                      return PageView.builder(
                                        controller: _pageController,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return AnimatedBuilder(
                                            animation: _pageController,
                                            builder: (BuildContext context,
                                                Widget widget) {
                                              double value = 1;
                                              if (_pageController
                                                  .position.haveDimensions) {
                                                value = _pageController.page -
                                                    index; //index
                                                value = (1 -
                                                        (value.abs() * 0.3) +
                                                        0.06)
                                                    .clamp(0.0, 1.0);
                                              }
                                              return Center(
                                                child: SizedBox(
                                                  height: Curves.easeInOut
                                                          .transform(value) *
                                                      125.0,
                                                  width: Curves.easeInOut
                                                          .transform(value) *
                                                      350.0,
                                                  child: widget,
                                                ),
                                              );
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                // moveCamera();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ProdutHomePage(
                                                            shopModel: snapshot
                                                                .data
                                                                .docs[index]),
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 20.0,
                                                        ),
                                                        height: 125.0,
                                                        width: 275.0,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black54,
                                                                offset: Offset(
                                                                    0.0, 4.0),
                                                                blurRadius:
                                                                    10.0,
                                                              ),
                                                            ]),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              color: AppTheme
                                                                  .nearlyWhite),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  height: 90.0,
                                                                  width: 90.0,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft: Radius.circular(
                                                                              10.0),
                                                                          topLeft: Radius.circular(
                                                                              10.0)),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(snapshot.data.docs[index]
                                                                              [
                                                                              'image_url_shop']),
                                                                          fit: BoxFit
                                                                              .cover))),
                                                              SizedBox(
                                                                  width: 5.0),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data
                                                                            .docs[index]
                                                                        [
                                                                        'name_shopping'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.5,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                    snapshot.data.docs[index]
                                                                            [
                                                                            'open_at_shop'] +
                                                                        "|" +
                                                                        snapshot
                                                                            .data
                                                                            .docs[index]['close_at_shop'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        170.0,
                                                                    child: Text(
                                                                      snapshot
                                                                          .data
                                                                          .docs[index]['address_shop'],
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11.0,
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                }
                              },
                            ),
                          ),
                        )
                      : Container()
                ],
              )),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> loadAllShop() {
    return FirebaseFirestore.instance
        .collection(SHOP_URL)
        .limit(50)
        .snapshots();
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      FirebaseFirestore.instance.collection(SHOP_URL).get().then((docs) {
        if (docs.docs.isNotEmpty) {
          for (var i = 0; i < docs.docs.length; i++) {
            _controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(
                        double.parse(
                            docs.docs[_pageController.page.toInt()]
                                ['latitude_shop']),
                        double.parse(docs.docs[_pageController.page.toInt()]
                            ['longitude_shop'])),
                    zoom: 15.0,
                    bearing: 45.0,
                    tilt: 45.0)));
          }
        }
      });
    }
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.dark_grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
