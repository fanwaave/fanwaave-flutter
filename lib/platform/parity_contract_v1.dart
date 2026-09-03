/// Shared fan-engagement feature-parity contract with
/// `fanwaave/fanwaave-desktop-app.rs`. Native notification, lifecycle, share,
/// and secure-storage behavior belongs only in [AppPlatformAdapter].
const int crossPlatformParityContractVersion = 1;
const String rustDesktopCounterpart = 'fanwaave/fanwaave-desktop-app.rs';
enum AppSurface { mobile, flutterDesktop, rustDesktop }
enum AppCapability {
  authentication, creatorDiscovery, eventFeed, subscriptions, engagement,
  pushNotifications, desktopNotifications, deepLinks, shareIntent,
  secureStorage, offlineCache, backgroundSync, telemetry, accessibility,
  applicationUpdates,
}
const Set<AppCapability> requiredParityCapabilities = <AppCapability>{
  AppCapability.authentication, AppCapability.creatorDiscovery,
  AppCapability.eventFeed, AppCapability.subscriptions,
  AppCapability.engagement, AppCapability.pushNotifications,
  AppCapability.desktopNotifications, AppCapability.deepLinks,
  AppCapability.shareIntent, AppCapability.secureStorage,
  AppCapability.offlineCache, AppCapability.backgroundSync,
  AppCapability.telemetry, AppCapability.accessibility,
  AppCapability.applicationUpdates,
};
abstract class AppPlatformAdapter {
  const AppPlatformAdapter();
  AppSurface get surface;
  bool supports(AppCapability capability);
}
void verifyRequiredParityCapabilities(AppPlatformAdapter adapter) {
  final missing = requiredParityCapabilities
      .where((capability) => !adapter.supports(capability)).toList();
  if (missing.isNotEmpty) {
    throw StateError('Fanwaave parity gate failed for ${adapter.surface}: $missing');
  }
}
