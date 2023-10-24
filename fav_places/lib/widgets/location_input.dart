import 'package:fav_places/main.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? pickedLocation;
  bool isLocationLoading = false;

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isLocationLoading = true;
    });
    locationData = await location.getLocation();
    print(locationData.longitude);
    print(locationData.latitude);
    setState(() {
      isLocationLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: colorScheme.outline,
            ),
          ),
          child: Text(
            'No location chosen',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                getCurrentLocation();
              },
              icon: (isLocationLoading)
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : Icon(Icons.location_on),
              label: (isLocationLoading)
                  ? const Text('Fetching Location')
                  : const Text('Get Current Location'),
            ),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text('Select on Map')),
          ],
        )
      ],
    );
  }
}
