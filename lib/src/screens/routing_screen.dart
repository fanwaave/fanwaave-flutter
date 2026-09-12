import 'package:flutter/material.dart';

import '../widgets/workspace_widgets.dart';

class RoutingScreen extends StatelessWidget {
  const RoutingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkspacePage(
      title: 'Observable routing',
      subtitle:
          'See how reviewed signals could move through a route without enabling delivery or hiding unavailable dependencies.',
      children: <Widget>[
        WorkspaceSection(
          title: 'Route plan',
          icon: Icons.alt_route_outlined,
          child: Column(
            children: <Widget>[
              WorkspaceRow(
                title: '1 · Consent gate',
                detail: 'Require current scope and purpose',
                trailing: 'Required',
              ),
              Divider(),
              WorkspaceRow(
                title: '2 · Moment review',
                detail: 'Require provenance and model revision',
                trailing: 'Required',
              ),
              Divider(),
              WorkspaceRow(
                title: '3 · Delivery adapter',
                detail: 'No authenticated adapter is configured',
                trailing: 'Blocked',
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        WorkspaceSection(
          title: 'Delivery remains off',
          icon: Icons.pause_circle_outline,
          child: Text(
            'The app contains no credential, destination token, arbitrary URL, or background sender. Routing becomes actionable only through reviewed versioned contracts and explicit user authorization.',
          ),
        ),
      ],
    );
  }
}
