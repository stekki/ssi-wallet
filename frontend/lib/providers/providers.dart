import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/credential.dart';

final connectionsFutureProvider = FutureProvider<List<String>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              "Pasi95",
              "Brucewayne",
              "Akuankka",
            ]);
  },
);

final credentialsFutureProvider = FutureProvider<List<Credential>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              Credential(
                  issuer: "Verkkokauppa",
                  item: "Playstation 5",
                  date: "20.05.2023",
                  holder: "Matti Meikäläinen"),
              Credential(
                  issuer: "Aalto University",
                  item: "Aalto hoodie",
                  date: "01.02.2024",
                  holder: "Matti Meikäläinen"),
              Credential(
                  issuer: "Tector",
                  item: "MacBook Pro",
                  date: "25.12.2023",
                  holder: "Matti Meikäläinen"),
            ]);
  },
);
