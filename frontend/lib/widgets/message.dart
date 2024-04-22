import 'package:flutter/material.dart';
import 'package:frontend/services/job_service.dart';
import 'package:intl/intl.dart';
import '../utils/styles.dart';

abstract class AbstractChatCard extends StatelessWidget {
  final String sentBy;
  final DateTime timestamp;

  const AbstractChatCard({
    super.key,
    required this.sentBy,
    required this.timestamp,
  });
}

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
      final success = await JobService.sendResumeJobMutation(widget.jobID, accept);
    if (accept && success) {
      await JobService.sendMessage(widget.id, 'Buyer has accepted your identification request.');
    if (mounted) {
        setState(() {
            acceptDisabled = !accept;
            declineDisabled = !accept;
        });
      }
    } else {
      if (mounted) {
      setState(() {
        acceptDisabled = false;
        declineDisabled = false;
        });
      }
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
            const Text('The Seller requests identification'),
            ElevatedButton(
              onPressed: acceptDisabled ? null : () => doResume(true),
              child: const Text('Accept'),
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: declineDisabled ? null : () => doResume(false),
              child: const Text('Decline'),
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

class ProofRequestWidget extends AbstractChatCard {
  //final DateTime verifiedAt;
  //final DateTime approvedAt;

  const ProofRequestWidget({
    super.key,
    required super.sentBy,
    required super.timestamp,
    //required this.verifiedAt,
    //required this.approvedAt,
  });

  @override
  Widget build(BuildContext context) {
    Color color =
        sentBy == 'VERIFIER' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;
    if (sentBy == 'VERIFIER') {
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

    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment:
          sentBy == 'VERIFIER' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: sentBy == 'VERIFIER'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            const Text('Identification requested'),
            const SizedBox(height: 4),
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

class BasicChatMessageWidget extends AbstractChatCard {
  final String message;

  const BasicChatMessageWidget({
    super.key,
    required this.message,
    required super.sentBy,
    required super.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    Color color = sentBy == 'me' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;

    if (sentBy == 'me') {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
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

    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: sentBy == 'me' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: sentBy == 'me'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: DesignColors.textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
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

class ProofRequestCompleteWidget extends AbstractChatCard {
  const ProofRequestCompleteWidget({
    super.key,
    required super.sentBy,
    required super.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    Color color = sentBy == 'me' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;
    if (sentBy == 'me') {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
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

    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: sentBy == 'me' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: sentBy == 'me'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            const Text('Identification provided'),
            const SizedBox(height: 4),
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
class IdentificationProvidedWidget extends AbstractChatCard {
  const IdentificationProvidedWidget({
    super.key,
    required super.sentBy,
    required super.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    Color color = sentBy == 'me' ? DesignColors.messageColor : Colors.white;
    BorderRadiusGeometry borderRadius;
    if (sentBy == 'me') {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
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

    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: sentBy == 'me' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: sentBy == 'me'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            const Text('Identification provided'),
            const SizedBox(height: 4),
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
