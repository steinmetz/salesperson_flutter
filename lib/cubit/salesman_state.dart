part of 'salesman_cubit.dart';

@immutable
abstract class SalesPersonState extends Equatable {}

class SalesPersonInitial extends SalesPersonState {
  @override
  List<Object> get props => [];
}

class SalesPersonLoaded extends SalesPersonState {
  final LatLng centerPoint;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final double currentDistance;
  final double recordDistance;

  SalesPersonLoaded({
    @required this.centerPoint,
    this.currentDistance,
    this.recordDistance,
    this.markers: const {},
    this.polylines: const {},
  });

  @override
  List<Object> get props => [centerPoint, markers, polylines];

  SalesPersonLoaded copyWith({
    LatLng centerPoint,
    Set<Marker> markers,
    Set<Polyline> polylines,
    double currentDistance,
    double recordDistance,
  }) {
    return SalesPersonLoaded(
      currentDistance: currentDistance ?? this.currentDistance,
      recordDistance: recordDistance ?? this.recordDistance,
      centerPoint: centerPoint ?? this.centerPoint,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }
}
