import 'dart:math';

import 'dna.dart';
import 'gene.dart';
 
class Population {
  double mutationRate = 0.3;
  var population = <DNA>[];
  DNA bestEver;
  var recordDistance = double.infinity;
  Population({
    this.population,
    this.bestEver,
  });

  void createPopulation(int quantity, List<List<double>> points) {
    population = [];
    var genes = points
        .map((e) => Gene(
              latitude: e[0],
              longitude: e[1],
            ))
        .toList();

    for (var i = 0; i < quantity; i++) {
      genes.shuffle();
      population.add(DNA(genes: [...genes]));
    }
  }

  void suffle() {
    population.forEach((element) {
      element.genes.shuffle();
    });
  }

  void calcFitness() {
    population.forEach((element) {
      element.calcFitness();
      if (recordDistance > element.fitness) {
        bestEver = element;
      }
    });
  }

  void normalizeFitness() {
    var sum = 0.0;
    population.forEach((element) {
      sum += element.fitness;
    });
    population.forEach((element) {
      element.fitness = element.fitness / sum;
    });
  }

  void nextGeneration() {
    var newPopulation = <DNA>[];
    population.forEach((dad) {
      var mom = pickOne(population);
      var child = dad.crossover(mom);
      child.mutate(mutationRate);
      newPopulation.add(child);
    });
    population = newPopulation;
  }

  DNA pickOne(List<DNA> population) {
    var index = 0;
    var random = Random().nextDouble();
    while (random > 0) {
      random -= population[index].fitness;
      index++;
    }
    index--;
    if(index >= population.length) index = population.length-1;
    return population[index].copyWith();
    ;
  }
}
