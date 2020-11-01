import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesman/cubit/salesman_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SalesmanCubit(),
      child: MapScreenChild(),
    );
  }
}

class MapScreenChild extends StatefulWidget {
  MapScreenChild({Key key}) : super(key: key);

  @override
  _MapScreenChildState createState() => _MapScreenChildState();
}

class _MapScreenChildState extends State<MapScreenChild> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesmanCubit, SalesmanState>( 
      builder: (context, state) {
        return Scaffold(
          body: (state is SalesmanLoaded) ? _buildBody(state) : Container(),
        );
      },
    );
  }

  Widget _buildBody(SalesmanLoaded state) {
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: state.centerPoint, zoom: 14),
      markers: state.markers,
      polylines: state.polylines,
      onLongPress: (position)=>context.bloc<SalesmanCubit>().addPoint(position),
    );
  }
}
