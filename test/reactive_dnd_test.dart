import 'dart:async';
import 'dart:convert';

import 'package:fanwaave_flutter/src/dnd/reactive_dnd.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ores_dnd/ores_dnd.dart';
import 'package:ores_dnd/ores_dnd_reactive.dart';

DndEnvelope envelope(String dragId) => DndEnvelope(
      protocol: oresDndProtocol,
      dragId: dragId,
      sourceRuntime: 'fanwaave-flutter',
      allowedOperations: const [DndOperation.copy, DndOperation.move],
      items: const [
        DndItem(
          kind: DndItemKind.text,
          mediaType: 'text/plain',
          data: 'TOP-SECRET-FANWAAVE-DRAG-DATA',
        ),
      ],
    );

void main() {
  test('Flutter canary preserves lossless terminal events and redacts replay state', () async {
    final controller = FanwaaveReactiveDndController();
    final states = <DndReactiveState>[];
    final terminal = <DndLifecyclePhase>[];
    final telemetry = <DndTelemetryEvent>[];
    final subscriptions = <StreamSubscription<dynamic>>[
      controller.state.listen(states.add),
      controller.lossless.listen((event) => terminal.add(event.phase)),
      controller.telemetry.listen(telemetry.add),
    ];

    controller.start(envelope('drag-1'));
    controller.hover(envelope('drag-1'), 'timeline');
    controller.drop(
      envelope('drag-1'),
      operation: DndOperation.copy,
      targetId: 'timeline',
    );
    controller.end(
      envelope('drag-1'),
      operation: DndOperation.copy,
      targetId: 'timeline',
    );

    await Future<void>.delayed(Duration.zero);
    expect(terminal, [DndLifecyclePhase.drop, DndLifecyclePhase.dragEnd]);
    expect(states.last.active, isFalse);
    expect(states.last.itemCount, 1);
    expect(jsonEncode(states.map((state) => state.toJson()).toList()),
        isNot(contains('TOP-SECRET-FANWAAVE-DRAG-DATA')));
    expect(jsonEncode(telemetry.map((event) => event.toJson()).toList()),
        isNot(contains('TOP-SECRET-FANWAAVE-DRAG-DATA')));

    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
    await controller.dispose();
  });

  test('Flutter canary rejects invalid lifecycle and source-disallowed operation', () async {
    final dropFirst = FanwaaveReactiveDndController();
    expect(
      () => dropFirst.drop(
        envelope('drag-1'),
        operation: DndOperation.copy,
        targetId: 'timeline',
      ),
      throwsFormatException,
    );
    await dropFirst.dispose();

    final disallowed = FanwaaveReactiveDndController();
    disallowed.start(envelope('drag-2'));
    expect(
      () => disallowed.drop(
        envelope('drag-2'),
        operation: DndOperation.link,
        targetId: 'timeline',
      ),
      throwsFormatException,
    );
    await disallowed.dispose();
  });
}
