import 'package:flutter/material.dart';
import 'package:flutter_project/public/controller/base_controller.dart';

import 'base_loading_status_page.dart';

abstract class BaseLoadingPage<T extends BaseController>
    extends BaseLoadingStatusPage<T> {
  const BaseLoadingPage({super.key});

  Widget buildCompletedWidget(BuildContext context, T controller);

  Widget buildLoadingWidget(BuildContext context, T controller) =>
      const SizedBox.shrink();

  Widget buildErrorWidget(BuildContext context, Object? error, T controller) =>
      const SizedBox.shrink();

  @override
  Widget buildWidget(BuildContext context, T controller, ConnectionState state,
      bool hasError, Object? error) {
    if (state == ConnectionState.done) {
      if (hasError) {
        return buildErrorWidget(context, error, controller);
      } else {
        return buildCompletedWidget(context, controller);
      }
    } else {
      return buildLoadingWidget(context, controller);
    }
  }
}
