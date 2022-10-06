// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_manager.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $indexRoute,
    ];

GoRoute get $indexRoute => GoRouteData.$route(
      path: '/',
      factory: $IndexRouteExtension._fromState,
    );

extension $IndexRouteExtension on IndexRoute {
  static IndexRoute _fromState(GoRouterState state) => const IndexRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
