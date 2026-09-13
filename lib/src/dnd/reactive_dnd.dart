import 'package:ores_dnd/ores_dnd.dart';
import 'package:ores_dnd/ores_dnd_reactive.dart';

/// Fanwaave Flutter boundary around the shared ORES DnD RxDart state machine.
///
/// The controller owns no persistence side effect. A caller may observe
/// [lossless] to decide when to invoke an explicit accepted-drop commit, but
/// emitting lifecycle events alone never writes forms, local storage, or sync.
final class FanwaaveReactiveDndController {
  FanwaaveReactiveDndController() : _bus = OresDndReactiveBus();

  final OresDndReactiveBus _bus;

  Stream<DndReactiveState> get state => _bus.state;
  Stream<DndReactiveEvent> get dragOvers => _bus.events.where(
        (event) => event.phase == DndLifecyclePhase.dragOver,
      );
  Stream<DndReactiveEvent> get lossless => _bus.events.where(
        (event) =>
            event.phase == DndLifecyclePhase.drop ||
            event.phase == DndLifecyclePhase.dragEnd,
      );
  Stream<DndTelemetryEvent> get telemetry => _bus.telemetry;

  void start(DndEnvelope envelope) {
    _bus.emit(DndLifecyclePhase.dragStart, envelope);
  }

  void enterExternal(DndEnvelope envelope, String targetId) {
    _bus.emit(
      DndLifecyclePhase.dragEnter,
      envelope,
      targetId: targetId,
    );
  }

  void hover(DndEnvelope envelope, String targetId) {
    _bus.emit(
      DndLifecyclePhase.dragOver,
      envelope,
      targetId: targetId,
    );
  }

  void drop(
    DndEnvelope envelope, {
    required DndOperation operation,
    required String targetId,
  }) {
    _bus.emit(
      DndLifecyclePhase.drop,
      envelope,
      operation: operation,
      targetId: targetId,
    );
  }

  void end(
    DndEnvelope envelope, {
    DndOperation? operation,
    String? targetId,
  }) {
    _bus.emit(
      DndLifecyclePhase.dragEnd,
      envelope,
      operation: operation,
      targetId: targetId,
    );
  }

  Future<void> dispose() => _bus.dispose();
}
