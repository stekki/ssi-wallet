import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/credential.dart';

final connectionsFutureProvider = FutureProvider<List<String>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              "Pisshead",
              "Heikki",
              "Janne",
            ]);
  },
);

final credentialsFutureProvider = FutureProvider<List<Credential>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              Credential(name: "Verkkokauppa"),
              Credential(name: "Aalto University"),
              Credential(name: "Findy Agency"),
            ]);
  },
);
