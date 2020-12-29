import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salesman_app/cubit/salesman_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/salesman_cubit.dart';

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
    return BlocBuilder<SalesmanCubit, SalesPersonState>(
      builder: (context, state) {
        return Scaffold(
          body: (state is SalesPersonLoaded) ? _buildBody(state) : Container(),
        );
      },
    );
  }

  Widget _buildBody(SalesPersonLoaded state) {
    return Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          initialCameraPosition:
              CameraPosition(target: state.centerPoint, zoom: 14),
          markers: state.markers,
          polylines: state.polylines,
          onLongPress: (position) {
              context.bloc<SalesmanCubit>().addPoint(position);
              print('[${position.latitude},${position.longitude}],');
          }
        ),
        Positioned(
            bottom: 10,
            left: 10,
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'Start',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                context.bloc<SalesmanCubit>().calculate();
              },
            )),
        Positioned(
          right: 30,
          bottom: 30,
          child: Column(
            children: [
              Text('${state.currentDistance?.toStringAsFixed(2) ?? 0}', style: TextStyle(color: Colors.red, fontSize: 16),),
              Text('${state.recordDistance?.toStringAsFixed(2) ?? 0}', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          ),
        ),
      ],
    );
  }
}
