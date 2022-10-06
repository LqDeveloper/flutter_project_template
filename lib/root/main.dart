import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project/public/controller/base_controller.dart';
import 'package:flutter_project/public/widgets/base_loading_page.dart';
import 'package:flutter_project/public/widgets/base_loading_status_page.dart';
import 'package:flutter_project/public/widgets/base_page.dart';
import 'package:flutter_project/public/widgets/lifecycle_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routes: {'/pageTwo': (_) => const PageTwo()},
      home: const PageOne(),
      builder: EasyLoading.init(),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageOne'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/pageTwo');
            },
            child: const Text('点击跳转')),
      ),
    );
  }
}

class DemoController extends BaseController {}

class PageTwo extends BaseLoadingStatusPage<DemoController> {
  const PageTwo({Key? key}) : super(key: key);

  @override
  DemoController create(BuildContext context) {
    return DemoController();
  }

  @override
  Future startLoadingData(BuildContext context, DemoController controller) {
    return Future.delayed(const Duration(seconds: 5));
  }

  // @override
  // Future<bool> onWillPop(
  //     BuildContext context, DemoController controller) async {
  //   final dialogResult = await showDialog<bool>(
  //       context: context,
  //       builder: (_) {
  //         return AlertDialog(
  //           title: const Text('确定要退出吗？'),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(true);
  //                 },
  //                 child: const Text('确定')),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(false);
  //                 },
  //                 child: const Text('取消')),
  //           ],
  //         );
  //       });
  //   final result = dialogResult ?? false;
  //   return result;
  // }

  @override
  Widget buildWidget(BuildContext context, DemoController controller,
      ConnectionState state, bool hasError, Object? error) {
    if (state == ConnectionState.done) {
      controller.hideLoading();
    } else {
      controller.startLoading();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageTwo'),
      ),
      body: Center(
        child: TextButton(onPressed: () {}, child: const Text('点击跳转')),
      ),
    );
  }
}
