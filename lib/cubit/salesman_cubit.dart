import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:salesperson/salesperson.dart'; 

part 'salesman_state.dart';

class SalesmanCubit extends Cubit<SalesPersonState> {
  BitmapDescriptor icon;
  final salesman = SalesPerson();

  final route = [
    [51.67071748655678, 8.37641067802906],
    [51.67261606983089, 8.372891619801521],
    [51.671711180577056, 8.370173536241055],
    [51.670469007662376, 8.368399925529957],
    [51.669262566074174, 8.36542434990406],
    [51.671640069488106, 8.361733630299568],
  ];

  final route2 = [
    [51.68027134983452, 8.378198705613613],
    [51.68278256361327, 8.36809515953064],
    [51.68037009638432, 8.357949033379555],
    [51.675251623113, 8.356702141463757],
    [51.673025468059556, 8.363838829100132],
    [51.66691966536733, 8.35747629404068],
    [51.66467958344639, 8.366031534969807],
    [51.66439966939876, 8.377875834703445],
  ];

  final route3 = [
    [51.46607323261338, 8.22212666273117],
    [51.46960215740734, 8.191799595952034],
    [51.460904252020654, 8.175034113228321],
    [51.450671093914316, 8.189511001110077],
    [51.4445017199772, 8.16822499036789],
    [51.43373001176111, 8.174004144966602],
    [51.42780794907419, 8.21440190076828],
    [51.44086385393785, 8.227047510445118],
  ];

  SalesmanCubit() : super(SalesPersonInitial()) {
    init();
  }

  void init() async {
    icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/house.png');
    emit(
      SalesPersonLoaded(
        centerPoint: LatLng(51.44667723771266,8.200954981148243),
      ),
    );
    for (final point in route3) addPoint(LatLng(point[0], point[1]));
  }

  void addPoint(LatLng position) {
    final s = state as SalesPersonLoaded;

    var points = s.markers
        .map((e) => [
              e.position.latitude,
              e.position.longitude,
            ])
        .toList();
    points.add([position.latitude, position.longitude]);

    // if (points.length > 2) {
    //   points = salesman.calculateBestPath(
    //     startPoint: points[0],
    //     points: points,
    //   );
    // }
    var markers = Set<Marker>();
    var polylinePoints = List<LatLng>();
    points.forEach((point) {
      final latLng = LatLng(point[0], point[1]);
      polylinePoints.add(latLng);
      markers.add(
        Marker(
          icon: icon,
          markerId: MarkerId('${latLng.latitude},${latLng.longitude}'),
          position: latLng,
        ),
      );
    });

    final polyline = Polyline(
      polylineId: PolylineId(
        DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      color: Colors.red,
      width: 1,
      points: polylinePoints,
    );

    emit(s.copyWith(
      markers: markers,
      polylines: {polyline},
    ));
  }

  void calculate() async {
    final s = state as SalesPersonLoaded;
    final salesman = SalesPerson();

    var stream = salesman.stream;

    stream.listen(
      (event) {
        print(event['distance']);
        List<List<double>> route = event['route'];
        List<List<double>> bestRoute = event['bestRoute'];

        final routePolyline = Polyline(
          polylineId: PolylineId(
            'routePolyline',
          ),
          color: Colors.red,
          width: 1,
          points: route.map((e) => LatLng(e[0], e[1])).toList(),
        );

        final bestPolyline = Polyline(
          polylineId: PolylineId(
            'bestRoutePolyline',
          ),
          color: Colors.blue,
          width: 3,
          points: bestRoute.map((e) => LatLng(e[0], e[1])).toList(),
        );

        emit(s.copyWith(
            currentDistance: event['distance'],
            recordDistance: event['recordDistance'],
            polylines: {routePolyline, bestPolyline}));
      },
      onDone: () => print('acabou'),
    );

    var points = s.markers
        .map((e) => [
              e.position.latitude,
              e.position.longitude,
            ])
        .toList();

    await salesman.calculateBestPath(
      points: points,
      startPoint: route[0],
    );
  }
}
