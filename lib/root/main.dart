import 'package:flutter/material.dart';
import 'package:flutter_project/configs/app_init.dart';
import 'package:flutter_project/configs/router_manager.dart';
import 'package:flutter_project/configs/theme_manager.dart';
import 'package:flutter_project/public/widgets/custom_button.dart';

void main() async {
  await AppInit.init();
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
      builder: ThemeManager.setupTransitionBuilder(),
      home: const PageOne(),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标题'),
      ),
      body: Center(
        child: CustomButton(
          width: 150,
          height: 60,
          onPressed: () {
            Navigator.of(context).pushNamed('/pageTwo');
          },
          textColor: Colors.red,
          textStyle: const TextStyle(fontSize: 30),
          backgroundColor: Colors.green,
          // elevation: 20,
          // alignment: Alignment.centerRight,
          // side: BorderSide(width: 3, color: Colors.blue),

          allRadius: 30,
          title: '按钮',
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
          // child: const Text('这是按钮'),
        ),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageTwo'),
      ),
      body: Center(
        child: CustomButton(
          title: 'PageTwo',
          width: 150,
          height: 60,
          onPressed: () {},
          textColor: Colors.red,
          textStyle: const TextStyle(fontSize: 30),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
