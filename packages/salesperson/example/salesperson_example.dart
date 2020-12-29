

import '../lib/salesperson.dart';

void main() async {

  final route = [
    [51.670469007662376, 8.368399925529957], //4
    [51.671711180577056, 8.370173536241055], //3
    [51.67071748655678, 8.37641067802906], //1
    [51.671640069488106, 8.361733630299568], //6
    [51.669262566074174, 8.36542434990406], //5
    [51.67261606983089, 8.372891619801521], //2
  ];
  final salesman = SalesPerson();

  var stream = salesman.stream;

  stream.listen((event) {
    print(event);
    
  },
  onDone: () => print('acabou'),
  
  
  );

  await salesman.calculateBestPath(
    points: route,
    startPoint: route[0],
  );
}
