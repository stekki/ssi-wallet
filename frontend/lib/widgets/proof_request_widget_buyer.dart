import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/services/job_service.dart';
import 'package:frontend/utils/constants.dart';
import 'package:intl/intl.dart';
import '../utils/styles.dart';

class ProofRequestWidgetBuyer extends StatefulWidget {
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

class ProofRequestWidgetBuyerState extends State<ProofRequestWidgetBuyer> {
  bool acceptDisabled = false;
  bool declineDisabled = false;

  void doResume(bool accept) async {
    print("pressed");
      await JobService.sendResumeJobMutation(widget.jobID, accept);
      if(!accept) {
        setState(() {
          acceptDisabled = true;
          declineDisabled = true;
        });
      }
  }

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
                  ElevatedButton(onPressed: acceptDisabled ? null : () => doResume(true),
                    child: const Text('Accept'),
                  ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: declineDisabled ? null : () => doResume(false),
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
