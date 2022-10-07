import 'package:flutter/material.dart';
import 'package:flutter_project/public/controller/base_controller.dart';
import 'package:flutter_project/public/widgets/base_loading_page.dart';

abstract class BaseLoadingStatusPage<T extends BaseController, V>
    extends BaseLoadingPage<T, V> {
  const BaseLoadingStatusPage({super.key});

  Widget buildCompletedWidget(BuildContext context, T controller, V value);

  Widget buildLoadingWidget(BuildContext context, T controller) =>
      const SizedBox.shrink();

  Widget buildErrorWidget(BuildContext context, Object? error, T controller) =>
      const SizedBox.shrink();

  @override
  Widget buildWidget(
      BuildContext context, T controller, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return buildErrorWidget(context, snapshot.error, controller);
      } else {
        return buildCompletedWidget(context, controller, snapshot.data);
      }
    } else {
      return buildLoadingWidget(context, controller);
    }
  }
}