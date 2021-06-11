import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'fill_info.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var geoLocator = Geolocator();
  Position currentPosition;
  Set<Marker> _markers = {};
  String _mapStyle;

  @override
  void initState(){
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

    _markers.add(Marker(
        markerId: MarkerId("a"),
        draggable: true,
        position: latLngPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onDragEnd: (_currentlatLng) {
          latLngPosition = _currentlatLng;
        }));
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.903623, 67.198376),
    zoom: 18,
  );

  Icon cusIcon = Icon(
    Icons.search,
    color: Colors.white,
    size: 25,
  );

  Widget cusSearchBar = Text(
    'Gameio',
    style: TextStyle(
      fontFamily: 'JuliusSansOne',
      fontWeight: FontWeight.bold,
    ),
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
                title: Text('Edit Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FillInfo()),
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
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              setState(() {
                if(this.cusIcon.icon == Icons.search)
                  {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: ("Search"),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    );


                  }
                else
                  {
                    this.cusIcon = Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    );

                    this.cusSearchBar = Text(
                      'Gameio',
                      style: TextStyle(
                        fontFamily: 'JuliusSansOne',
                        fontWeight: FontWeight.bold,
                      ),
                    );

                  }
              });

            },
            icon: cusIcon,
            label: Text(''),
          ),
        ],
        title: Center(
          child: Container(
            alignment: Alignment.center,
            child: cusSearchBar,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Flexible(
            child: Container(
              height: 300,
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
    );
  }
}
