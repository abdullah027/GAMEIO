import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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

  void locatePosition () async {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;

      LatLng latLngPosition = LatLng(position.latitude, position.longitude);
      CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom: 14 );
      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(24.903623,67.198376),
      zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Drawer(
          child: Container(
            color: Color(0xFF080B1E),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF111439),
                  ),
                  child: Text('Drawer Header'),
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
              onPressed:(){
                context.read<AuthenticationService>().signOut();
              },
              icon: Icon(Icons.logout,color: Colors.white,),
              label: Text(''),
          ),
        ],
        title: Center(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Gameio',
              style: TextStyle(
                fontFamily: 'JuliusSansOne',
                fontWeight: FontWeight.bold,
              ),
            ),
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
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,

               onMapCreated: (GoogleMapController controller){
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;

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
