import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Geolo extends StatefulWidget {
  @override
  _GeoloState createState() => _GeoloState();
}

class _GeoloState extends State<Geolo> {
  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;

  @override
  void initState() {
      _streamSubscription = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Convet geocodes to Address'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
                'Location lat ${_position?.latitude ?? '-'} lon: ${_position?.longitude ?? '-'}'),
            SizedBox(height: 50),
            Text('Address from coordinates'),
            SizedBox(height: 50),
            Text('${_address?.coordinates?? '-'}'),
          ],
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
}


/*
class Geolo extends StatefulWidget {
  @override
  _GeoloState createState() => _GeoloState();
}

class _GeoloState extends State<Geolo> {
  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;

  @override
  void initState() {
    _streamSubscription = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Convet geocodes to Address'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
                'Location lat ${_position?.latitude ?? '-'} lon: ${_position?.longitude ?? '-'}'),
            SizedBox(height: 50),
            Text('Address from coordinates'),
            SizedBox(height: 50),
            Text('${_address?.coordinates?? '-'}'),
          ],
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
}
*/
