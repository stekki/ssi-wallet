import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/services/connection_service.dart';
import 'package:frontend/services/message_service.dart';
import 'package:frontend/widgets/credential.dart';

final connectionServiceProvider = Provider((ref) => ConnectionService());
final messageServiceProvider = Provider((ref) => MessageService());

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
