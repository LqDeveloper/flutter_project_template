import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/public/controller/base_controller.dart';
import 'package:flutter_project/public/widgets/base_page.dart';

abstract class BaseLoadingStatusPage<T extends BaseController>
    extends BasePage<T> {
  const BaseLoadingStatusPage({super.key});

  Future startLoadingData(BuildContext context, T controller);

  Widget buildWidget(BuildContext context, T controller, ConnectionState state,
      bool hasError, Object? error);

  @override
  Widget build(BuildContext context, T controller) {
    return FutureBuilder(
        future: startLoadingData(context, controller),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return buildWidget(context, controller, snapshot.connectionState,
              snapshot.hasError, snapshot.error);
        });
  }
}
