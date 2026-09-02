import 'package:flutter/material.dart';

import '../widgets/workspace_widgets.dart';

class MomentsScreen extends StatelessWidget {
  const MomentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WorkspacePage(
      title: 'Moment scoring',
      subtitle:
          'Review bounded scoring examples without presenting synthetic fixtures as live audience measurements.',
      children: <Widget>[
        WorkspaceSection(
          title: 'Candidate moments',
          icon: Icons.bolt_outlined,
          child: Column(
            children: <Widget>[
              _MomentTile(
                title: 'Launch conversation',
                detail: 'Relevance 82 · Confidence not evaluated',
                label: 'Preview',
              ),
              Divider(),
              _MomentTile(
                title: 'Community response window',
                detail: 'Relevance 71 · Confidence not evaluated',
                label: 'Preview',
              ),
              Divider(),
              _MomentTile(
                title: 'Follow-up opportunity',
                detail: 'Relevance 64 · Confidence not evaluated',
                label: 'Preview',
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        WorkspaceSection(
          title: 'Scoring boundary',
          icon: Icons.rule_outlined,
          child: Text(
            'Scores on this screen are immutable design fixtures. A future typed client must supply provenance, consent state, model revision, and confidence before a score may influence routing.',
          ),
        ),
      ],
    );
  }
}

class _MomentTile extends StatelessWidget {
  const _MomentTile({
    required this.title,
    required this.detail,
    required this.label,
  });

  final String title;
  final String detail;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(child: Icon(Icons.timeline_outlined)),
      title: Text(title),
      subtitle: Text(detail),
      trailing: Chip(label: Text(label)),
    );
  }
}
