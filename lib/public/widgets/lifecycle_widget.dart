import 'package:flutter/material.dart';

class LifecycleWidget extends StatefulWidget {
  final VoidCallback? initState;
  final VoidCallback? dispose;
  final Widget child;

  const LifecycleWidget(
      {Key? key, required this.child, this.initState, this.dispose})
      : super(key: key);

  @override
  State<LifecycleWidget> createState() => _LifecycleWidgetState();
}

class _LifecycleWidgetState extends State<LifecycleWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.initState != null) {
      widget.initState!();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.dispose != null) {
      widget.dispose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
