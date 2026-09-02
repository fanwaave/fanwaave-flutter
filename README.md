# fanwaave-flutter

Flutter workspace for Fanwaave’s consent-aware audience signals, moment
scoring, and observable routing. UI remains native Flutter under `lib/src/`;
there is no React, JSX, or webview application shell.

## Screens

1. **Signals** — disconnected service status, consent-aware metrics, and
   synthetic local templates.
2. **Moments** — bounded scoring previews with a visible provenance and
   confidence boundary.
3. **Routing** — a reviewable route plan whose delivery adapter remains blocked
   until typed authenticated contracts are configured.

The first frame and all three routes work without credentials or connectivity.
Sample values are presentation fixtures, never claims about live participants.

## Validate

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos --fatal-warnings
flutter test
flutter build web --release
```

The web runner is committed. Mobile and desktop runner generation remains a
separate pinned-toolchain change; no generated files or lockfile are fabricated
by hand in this slice.
