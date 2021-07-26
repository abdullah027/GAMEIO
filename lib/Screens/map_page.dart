import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Screens/search_data.dart';
import 'package:gameio/Screens/user_info.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:gameio/Services/user_details.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'profile.dart';
import 'settings.dart';
import 'settings.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  BitmapDescriptor myIcon;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var geoLocator = Geolocator();
  Position currentPosition;
  Set<Marker> _markers = {};
  String _mapStyle;


  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)),
            'assets/images/icons8-street-view-96.png')
        .then((onValue) {
      myIcon = onValue;
    });
    super.initState();
    locatePosition();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 18);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("a"),
          draggable: true,
          position: latLngPosition,
          icon: myIcon,
          infoWindow: InfoWindow(title: "Username", snippet: 'Playing CSGO'),
          onDragEnd: (_currentlatLng) {
            latLngPosition = _currentlatLng;
          }));
    });
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.903623, 67.198376),
    zoom: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Container(
          color: Color(0xFF080B1E),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF111439),
                ),
                child: Text('GAMEIO'),
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FillInfo()),
                  );
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
              ),
              ListTile(
                title: Text('LogOut'),
                onTap: () {
                  context.read<AuthenticationService>().signOut();
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Gameio',
          style: TextStyle(
            fontFamily: 'JuliusSansOne',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              //SizedBox(
              //height: 0,
              //),
              Flexible(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    markers: _markers,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;
                      newGoogleMapController.setMapStyle(_mapStyle);

                      locatePosition();
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 100,
              right: 10,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black54),
                ),
                child: Icon(Icons.pin_drop),
                onPressed: () => locatePosition(),
              ))
        ],
      ),
    );
  }
}