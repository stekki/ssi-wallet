import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectionsFutureProvider = FutureProvider<List<String>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 3), () => ["Aalto University", "Finland"]);
  },
);
