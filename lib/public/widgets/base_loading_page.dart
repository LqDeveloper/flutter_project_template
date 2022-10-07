import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/public/controller/base_controller.dart';
import 'package:flutter_project/public/widgets/base_page.dart';

abstract class BaseLoadingPage<T extends BaseController, V>
    extends BasePage<T> {
  const BaseLoadingPage({super.key});

  Future<V> startLoadingData(BuildContext context, T controller);

  Widget buildWidget(
      BuildContext context, T controller, AsyncSnapshot snapshot);

  @override
  Widget build(BuildContext context, T controller) {
    return FutureBuilder<V>(
        future: startLoadingData(context, controller),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return buildWidget(context, controller, snapshot);
        });
  }
}
