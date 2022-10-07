import 'package:flutter/material.dart';
import 'package:flutter_project/pages/index/index_controller.dart';
import 'package:flutter_project/public/widgets/base_page.dart';

class IndexPage extends BasePage<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, IndexController controller) {
    return Container();
  }

  @override
  IndexController create(BuildContext context) {
    return IndexController();
  }
}
