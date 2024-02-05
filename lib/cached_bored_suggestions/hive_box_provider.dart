import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final hiveBoxProvider = Provider((ref) {
  return Hive.box();
});
