part of 'salesman_cubit.dart';

@immutable
abstract class SalesmanState extends Equatable {}

class SalesmanInitial extends SalesmanState {
  @override
  List<Object> get props => [];
}

class SalesmanLoaded extends SalesmanState {
  final LatLng centerPoint;
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  SalesmanLoaded({
    @required this.centerPoint,
    this.markers: const {},
    this.polylines: const {},
  });

  @override
  List<Object> get props => [centerPoint, markers, polylines];

  SalesmanLoaded copyWith({
    LatLng centerPoint,
    Set<Marker> markers,
    Set<Polyline> polylines,
  }) {
    return SalesmanLoaded(
      centerPoint: centerPoint ?? this.centerPoint,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }
}
