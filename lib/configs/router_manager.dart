import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/pages/index/index_page.dart';
import 'package:go_router/go_router.dart';

part 'router_manager.g.dart';

abstract class RouterPath {
  static const String index = '/';
}

final router = GoRouter(routes: $appRoutes);

abstract class BaseRouterData extends GoRouteData {
  const BaseRouterData();

  bool get shouldRedirect => false;

  @override
  FutureOr<String?> redirect() => shouldRedirect ? '' : null;
}

@TypedGoRoute<IndexRoute>(path: RouterPath.index)
class IndexRoute extends BaseRouterData {
  const IndexRoute();

  @override
  Widget build(BuildContext context) => const IndexPage();
}
