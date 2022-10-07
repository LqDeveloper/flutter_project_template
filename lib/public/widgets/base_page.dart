import 'package:flutter/material.dart';
import 'package:flutter_project/public/controller/base_controller.dart';
import 'package:flutter_project/public/widgets/lifecycle_widget.dart';
import 'package:provider/provider.dart';

abstract class BasePage<T extends BaseController> extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  bool get wantKeepAlive => false;

  bool get observeKeyboard => false;

  T create(BuildContext context);

  Widget build(BuildContext context, T controller);

  void initState() {}

  void dispose() {}

  Future<bool> onWillPop(BuildContext context, T controller) async {
    return true;
  }

  //observeKeyboard返回为true的时候才会调用这个方法
  void keyboardShowOrHide(bool show, double keyboardHeight) {}

  @override
  State<BasePage<T>> createState() => BasePageState<T>();
}

class BasePageState<T extends BaseController> extends State<BasePage<T>>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (widget.observeKeyboard) {
      WidgetsBinding.instance.addObserver(this);
    }
    widget.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.observeKeyboard) {
      WidgetsBinding.instance.removeObserver(this);
    }
    widget.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final viewInsets = MediaQuery.of(context).viewInsets;
      if (viewInsets.bottom == 0) {
        widget.keyboardShowOrHide(false, 0);
      } else {
        widget.keyboardShowOrHide(true, viewInsets.bottom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: widget.create,
      child: Builder(
        builder: (cxt) {
          final controller = cxt.read<T>();
          return WillPopScope(
            onWillPop: () async {
              final result = await widget.onWillPop(context, controller);
              return result;
            },
            child: LifecycleWidget(
                initState: () {
                  controller.onInit();
                },
                child: widget.build(cxt, controller)),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
