import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/credential.dart';

final connectionsFutureProvider = FutureProvider<List<String>>(
  (ref) async {
    return await Future.delayed(const Duration(seconds: 2),
        () => ["Aalto University", "Finland", "OP Financial Group"]);
  },
);

final credentialsFutureProvider = FutureProvider<List<Credential>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 2),
        () => [
              Credential(name: "Verkkokauppa"),
              Credential(name: "Aalto University"),
              Credential(name: "Findy Agency"),
              Credential(name: "Findy Agency"),
              Credential(name: "Findy Agency"),
              Credential(name: "Findy Agency"),
              Credential(name: "Findy Agency"),
            ]);
  },
);
