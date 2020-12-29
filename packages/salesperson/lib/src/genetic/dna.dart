import 'dart:math';

import 'package:geodesy/geodesy.dart';

import 'gene.dart'; 

class DNA {
  final _geodesy = Geodesy();
  List<Gene> genes;
  double fitness = 0;
  double distance = 0;
  double scaledFitness = 0;

  DNA({
    this.genes,
    double fitness,
    double scaledFitness,
  });

  List<List<double>> getGenes(){
    return genes.map((e) => [e.latitude, e.longitude]).toList();
  }

  void calcFitness() {
    fitness = 0;
    distance = 0;
    for (var i = 0; i < genes.length - 1; i++) {
      distance += _geodesy.distanceBetweenTwoGeoPoints(
        LatLng(genes[i].latitude, genes[i].longitude),
        LatLng(genes[i + 1].latitude, genes[i + 1].longitude),
      );
    }
    // the higher the distance is, the lower is its fitness
    fitness = 1 / (distance + 1);
  }

  DNA crossover(DNA partner) {
    var start = Random().nextInt(genes.length);
    var end = _next(start, genes.length);
    var newGenes = genes.sublist(start, end);

    partner.genes.forEach((gene) {
      if (!newGenes.contains(gene)) newGenes.add(gene);
    });
    return DNA(genes: newGenes);
  }

  int _next(int min, int max) => min + Random().nextInt(max - min);

  void mutate(double mutationRate) {
    if (Random().nextDouble() < mutationRate) {
      genes.shuffle();
    }
    // var indexA = 0;
    // var indexB = 0;
    // for(var i =0; i<genes.length; i++){
    //   if(Random().nextDouble() < mutationRate){

    //     indexA = Random().nextInt(genes.length-1);
    //   }
    // };
  }

  DNA copyWith({
    List<Gene> genes,
    double fitness,
    double scaledFitness,
  }) {
    return DNA(
      genes: genes ?? this.genes,
      fitness: fitness ?? this.fitness,
      scaledFitness: scaledFitness ?? this.scaledFitness,
    );
  }
}
