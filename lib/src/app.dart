import 'package:flutter/material.dart';

import 'home_page.dart';
import 'theme.dart';

class FanwaaveApp extends StatelessWidget {
  const FanwaaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fanwaave',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const HomePage(),
    );
  }
}
