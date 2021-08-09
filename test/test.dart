import 'dart:math';

main(List<String> args) {
  final now = DateTime.now();
  final startTime =
      DateTime(now.year, now.month, now.day, 0, 0, 0).millisecondsSinceEpoch;
  final endTime =
      DateTime(now.year, now.month, now.day, 23, 59, 59).millisecondsSinceEpoch;

  print(now);
  print(startTime);
  print(endTime);

  print('===');
  // final random = Random();
  // for(int i=0; i<20; i++){
  //   print('random:${random.nextInt(3)}');
  // }
}
