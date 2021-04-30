import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final CameraPosition _initialPosition = CameraPosition(target: LatLng(24.903623,67.198376));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
              onPressed:(){},
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
          Expanded(
            flex: 0,
            child: Container(
              height: 300,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                mapType: MapType.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
