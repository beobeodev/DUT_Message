import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/message.model.dart';
import 'package:get/get.dart';

class ImageContent extends StatelessWidget {
  final Message message;

  const ImageContent({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: message.content,
      placeholder: (context, url) {
        return SizedBox(
          width: Get.width / 2 + 40,
          height: 60,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: Get.width / 2 + 40,
    );
  }
}
