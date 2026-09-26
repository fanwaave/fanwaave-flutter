import 'package:fanwaave_flutter/src/app.dart';
import 'package:flutter/widgets.dart';
import 'package:ores_otel_flutter/ores_otel_flutter.dart';

void main() {
  final logger = Logger(appName: 'fanwaave_flutter');
  runOresFlutterApp(
    appName: 'fanwaave_flutter',
    emitToDeveloperLog: false,
    sinks: [NextLoggersStartupDiagnosticSink(logger: logger)],
    builder: (_) => const FanwaaveApp(),
  );
}

