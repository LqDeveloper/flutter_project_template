import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImageWidget extends StatelessWidget {
  final String? imageUrl;
  final Widget? placeholder;

  const CachedImageWidget({Key? key, required this.imageUrl, this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = imageUrl ?? '';
    final placeholderWidget = placeholder ?? const SizedBox();
    if (url.isEmpty) {
      return placeholderWidget;
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        errorWidget: (_, __, ___) => placeholderWidget,
        placeholder: (_, __) => placeholderWidget,
      );
    }
  }
}
