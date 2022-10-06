import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class DataWrapper<T> {
  T? data;
  bool updateTag = false;

  void updateData(T? data) {
    this.data = data;
    updateTag = !updateTag;
  }
}

typedef WrapperWidgetBuilder<T> = Widget Function(
    BuildContext context, T controller, Widget? child);

class WrapperSelector<A, S> extends Selector<A, S> {
  WrapperSelector({
    Key? key,
    required WrapperWidgetBuilder<A> builder,
    required S Function(BuildContext, A) selector,
    ShouldRebuild<S>? shouldRebuild,
    Widget? child,
  }) : super(
            key: key,
            builder: (BuildContext context, S value, Widget? child) {
              return builder(context, Provider.of<A>(context), child);
            },
            selector: selector,
            shouldRebuild: shouldRebuild,
            child: child);
}

T? _ambiguate<T>(T? value) => value;

abstract class BaseController extends ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;
  bool _isShowLoading = false;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    if (_isShowLoading) {
      hideLoading(animation: false);
    }
    super.dispose();
  }

  void onInit() {
    _ambiguate(SchedulerBinding.instance)
        ?.addPostFrameCallback((_) => onReady());
  }

  @protected
  void onReady() {}

  void startLoading() {
    _isShowLoading = true;
    EasyLoading.show(
        indicator: Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(20),
      color: Colors.cyan,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.red),
      ),
    ));
  }

  void hideLoading({bool animation = true}) {
    _isShowLoading = false;
    EasyLoading.dismiss(animation: animation);
  }
}
