import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;
  Timer? _locationTimer;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      _sendLocationToServer(_currentPosition!, _currentAddress);
      // Start the timer to get location updates every 5 seconds
      _locationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        _getCurrentPosition();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _sendLocationToServer(Position position, String? address) async {
    String baseUrl = "http://10.11.2.184:3000/";
    final response = await http.post(
      Uri.parse(baseUrl + "location"),
      body: {
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
        'address': address ?? '',
      },
    );

    if (response.statusCode == 200) {
      print('Location sent successfully');
    } else {
      print('Failed to send location. Status code: ${response.statusCode}');
    }
  }

  void _stopLocationUpdates() {
    // Stop the location updates when the "Stop" button is pressed
    if (_locationTimer != null) {
      _locationTimer!.cancel();
      _locationTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Latitude: ${_currentPosition?.latitude ?? ""}'),
              const SizedBox(height: 15),
              Text('Longitude: ${_currentPosition?.longitude ?? ""}'),
              const SizedBox(height: 15),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _stopLocationUpdates,
                child: const Text("Stop"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
