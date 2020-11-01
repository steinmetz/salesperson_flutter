class SalesMan {

  /// [startPoint] array with [latitude, longitude] 
  /// 
  /// 
  /// [points] all points, including the startPoint [ [latitude1, longitude1], [latitude2, longitude2] ...]

  List<List<double>> calculateBestPath({
    List<double> startPoint,
    List<List<double>> points,
  }) {
    if (points.contains(startPoint)) points.remove(startPoint);

    // logic goes here


    return [startPoint, ...points];
  }

  List<List<double>> swap(List<List<double>> points, i, j){
    final temp = points[i];
    points[i] = points[j];
    points[j] = temp;
    return points;
  }
}
