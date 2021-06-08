import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoursuperideaechnologies/shopinfo.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

          primaryColor:Colors.grey[800]
      ),
      home: MyApp()
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
 GoogleMapController mapController;
Map<MarkerId, Marker> markers = <MarkerId,Marker>{};
BitmapDescriptor mapmarker;
  final LatLng _center = const LatLng(19.175237, 72.867215);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  void customerMarker()async{
    mapmarker=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/store.png');
  }
  void askPermission() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }
void initMarker(specify,specifyId) async{
    double lat, long;
    lat=specify['vendor_latitude'];
    long=specify['vendor_longitute'];

    var markerIdval=specifyId;
    final MarkerId markerId=MarkerId(markerIdval);
    final Marker marker =Marker(
      markerId: markerId,

      position: LatLng(lat,long),
        icon: mapmarker,

      infoWindow: InfoWindow(title:specify['vendor_name'],
          snippet: 'Tap to see details',
      onTap:(){
        print(specify['vendor_name']);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShopInfo(specify['vendor_name'],specify['vendor_total_stock_value'],specify['vendor_image_url'])));
  }


       )
    );
    print(specify['vendor_name']);
    print(specify['vendor_latitude']);
    print(specify['vendor_longitute']);
    setState(() {
      markers[markerId]=marker;
    });
}
getMarkerData() async{
    Firestore.instance.collection('vendors').getDocuments().then((myData)
    {
      if (myData.documents.isNotEmpty){
        for(int i=0;i<myData.documents.length;i++){
          initMarker(myData.documents[i].data, myData.documents[i].documentID);

        }
      }
    });
}
void initState(){
    askPermission();
    getMarkerData();
    customerMarker();
    super.initState();
}

  @override
  Widget build(BuildContext context) {

    Set<Marker> getMarker(){
      return <Marker>[
        Marker(
          markerId: MarkerId('My Home'),
          position: LatLng(19.175280, 72.86619),

          infoWindow: InfoWindow(title: 'home')

        )
      ].toSet();
    }
    return MaterialApp(
      title: 'YourSuperIdea Technologies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor:Colors.grey[800]
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('YourSuperIdea Technologies'),
          elevation: 0.0,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)
              )
          ),
        ),
        body: GoogleMap(
          markers: Set<Marker>.of(markers.values),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 10.0,
          ),
        ),
      ),
    );
  }
}

