import 'package:flutter/material.dart';

import '../api/models.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key, required this.status});

  final ConnectionStatus status;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: status.connected
                  ? colors.primaryContainer
                  : colors.errorContainer,
              child: Icon(
                status.connected ? Icons.cloud_done : Icons.cloud_off,
                color: status.connected
                    ? colors.onPrimaryContainer
                    : colors.onErrorContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    status.connected
                        ? 'Audience service connected'
                        : 'Audience service disconnected',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(status.endpoint),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
