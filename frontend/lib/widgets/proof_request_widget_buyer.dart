import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/services/job_service.dart';
import 'package:frontend/utils/constants.dart';
import 'package:intl/intl.dart';
import '../utils/styles.dart';

class ProofRequestWidgetBuyer extends ConsumerStatefulWidget {
  final String sentBy;
  final DateTime timestamp;
  final String jobID;
  final String status;
  final String id;

  const ProofRequestWidgetBuyer({
    super.key,
    required this.id,
    required this.sentBy,
    required this.timestamp,
    required this.jobID,
    required this.status,
  });

  @override
  ProofRequestWidgetBuyerState createState() => ProofRequestWidgetBuyerState();
}

class ProofRequestWidgetBuyerState extends ConsumerState<ProofRequestWidgetBuyer> {

  @override
  Widget build(BuildContext context) {
    Color color =
        widget.sentBy == 'PROVER' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;
    if (widget.sentBy == 'VERIFIER') {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(0),
      );
    } else {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(10),
      );
    }

    String formattedTime = DateFormat('hh:mm a').format(widget.timestamp);

    return Align(
      alignment: widget.sentBy == 'VERIFIER'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.sentBy == 'VERIFIER'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            const Text('Provide id to the seller'),
            const SizedBox(width: 4),
            SizedBox(
              width: 250,
              height: 40,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async => {
                      await JobService.sendResumeJobMutation(widget.jobID, true),
                       ref
                                        .watch(chatStatusProvider.notifier)
                                        .updateChatStatus(
                                            widget.id, ConnectionStatus.confirmed),
                      },
                    child: const Text('Accept'),
                  ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: () async => {
                      await JobService.sendResumeJobMutation(widget.jobID, false),
                       ref
                                        .watch(chatStatusProvider.notifier)
                                        .updateChatStatus(
                                            widget.id, ConnectionStatus.confirmed),
                      },
                    child: const Text('Decline'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8), // For spacing
            Text(
              formattedTime,
              style: TextStyle(
                color: DesignColors.textColor.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
