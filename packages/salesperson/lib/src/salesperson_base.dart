import 'dart:async';
 

import 'genetic/dna.dart';
import 'genetic/population.dart';

class SalesPerson {
  final _controller = StreamController<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get stream => _controller.stream;

  /// [startPoint] array with [latitude, longitude]
  ///
  ///
  /// [points] all points, including the startPoint [ [latitude1, longitude1], [latitude2, longitude2] ...]

  Future<List<List<double>>> calculateBestPath({
    List<double> startPoint,
    List<List<double>> points,
  }) async {
    //if (points.contains(startPoint)) points.remove(startPoint);

    DNA bestEver;
    var recordDistance = double.infinity;

    final population = Population();
    

    population.createPopulation(1000, points);

    for (var i = 0; i < 500; i++) {
      await Future.delayed(Duration(milliseconds: 70));
      population.calcFitness();
      population.normalizeFitness();
      population.nextGeneration();
      if (recordDistance > population.bestEver.distance) {
        recordDistance = population.bestEver.distance;
        bestEver = population.bestEver;
      }
      _controller.sink.add({
        'fitness': population.bestEver.fitness,
        'distance': population.bestEver.distance,
        'route': population.bestEver.getGenes(),
        'bestRoute': bestEver.getGenes(),
        'recordDistance': recordDistance,
      });
    }

    return [startPoint, ...points];
  }
}
