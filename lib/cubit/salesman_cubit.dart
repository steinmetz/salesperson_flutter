import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'salesman_state.dart';

class SalesmanCubit extends Cubit<SalesmanState> {
  final route = [
    [51.67071748655678, 8.37641067802906],
    [51.67261606983089, 8.372891619801521],
    [51.671711180577056, 8.370173536241055],
    [51.670469007662376, 8.368399925529957],
    [51.669262566074174, 8.36542434990406],
    [51.671640069488106, 8.361733630299568],
  ];
  SalesmanCubit() : super(SalesmanInitial()) {
    init();
  }

  void init() {
    emit(
      SalesmanLoaded(
        centerPoint: LatLng(51.6738048, 8.3627208),
      ),
    );
    for (final point in route) addPoint(LatLng(point[0], point[1]));
  }

  void addPoint(LatLng position) {
    final s = state as SalesmanLoaded;
    final newMarker = Marker(
      markerId: MarkerId(
        DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      position: position,
    );

    final markers = {
      ...s.markers,
      newMarker,
    };

    final polylinePoints = markers.map((e) => (e.position)).toList();
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
}
