import 'package:flutter/material.dart';

import '../api/models.dart';
import '../widgets/status_card.dart';
import '../widgets/workspace_widgets.dart';

class SignalsScreen extends StatelessWidget {
  const SignalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const ConnectionStatus status = ConnectionStatus(
      connected: false,
      endpoint: 'No typed endpoint configured',
    );

    return const WorkspacePage(
      title: 'Audience signals',
      subtitle:
          'Inspect consent-aware signal summaries immediately while every remote data path remains visibly disconnected.',
      children: <Widget>[
        StatusCard(status: status),
        SizedBox(height: 20),
        MetricGrid(
          metrics: <WorkspaceMetric>[
            WorkspaceMetric(
              label: 'Consented sources',
              value: '0',
              icon: Icons.verified_user_outlined,
            ),
            WorkspaceMetric(
              label: 'Fresh signals',
              value: '0',
              icon: Icons.waves_outlined,
            ),
            WorkspaceMetric(
              label: 'Candidate groups',
              value: '3',
              icon: Icons.groups_outlined,
            ),
          ],
        ),
        SizedBox(height: 20),
        WorkspaceSection(
          title: 'Local signal templates',
          icon: Icons.dataset_outlined,
          child: Column(
            children: <Widget>[
              WorkspaceRow(
                title: 'Engagement change',
                detail: 'Synthetic preview · no participant data',
                trailing: 'Template',
              ),
              Divider(),
              WorkspaceRow(
                title: 'Topic momentum',
                detail: 'Synthetic preview · no inferred identity',
                trailing: 'Template',
              ),
              Divider(),
              WorkspaceRow(
                title: 'Channel response',
                detail: 'Synthetic preview · no outbound action',
                trailing: 'Template',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
