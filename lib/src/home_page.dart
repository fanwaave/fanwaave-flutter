import 'package:flutter/material.dart';

import 'screens/moments_screen.dart';
import 'screens/routing_screen.dart';
import 'screens/signals_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<_Destination> _destinations = <_Destination>[
    _Destination(
      label: 'Signals',
      icon: Icons.radar_outlined,
      selectedIcon: Icons.radar,
    ),
    _Destination(
      label: 'Moments',
      icon: Icons.auto_graph_outlined,
      selectedIcon: Icons.auto_graph,
    ),
    _Destination(
      label: 'Routing',
      icon: Icons.route_outlined,
      selectedIcon: Icons.route,
    ),
  ];

  static const List<Widget> _screens = <Widget>[
    SignalsScreen(),
    MomentsScreen(),
    RoutingScreen(),
  ];

  int _selectedIndex = 0;

  void _selectDestination(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool showRail = constraints.maxWidth >= 900;
        final bool showStatus = constraints.maxWidth >= 560;
        final Widget content = IndexedStack(
          index: _selectedIndex,
          children: _screens,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text('Fanwaave · ${_destinations[_selectedIndex].label}'),
            actions: showStatus
                ? const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Center(
                        child: Chip(
                          avatar: Icon(Icons.visibility_outlined, size: 18),
                          label: Text('Local preview'),
                        ),
                      ),
                    ),
                  ]
                : null,
          ),
          body: SafeArea(
            child: showRail
                ? Row(
                    children: <Widget>[
                      NavigationRail(
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: _selectDestination,
                        labelType: NavigationRailLabelType.all,
                        destinations: _destinations
                            .map(
                              (_Destination destination) =>
                                  NavigationRailDestination(
                                icon: Icon(destination.icon),
                                selectedIcon: Icon(destination.selectedIcon),
                                label: Text(destination.label),
                              ),
                            )
                            .toList(growable: false),
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: content),
                    ],
                  )
                : content,
          ),
          bottomNavigationBar: showRail
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _selectDestination,
                  destinations: <NavigationDestination>[
                    for (int index = 0;
                        index < _destinations.length;
                        index += 1)
                      NavigationDestination(
                        key: ValueKey<String>('nav-$index'),
                        icon: Icon(_destinations[index].icon),
                        selectedIcon: Icon(_destinations[index].selectedIcon),
                        label: _destinations[index].label,
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class _Destination {
  const _Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
