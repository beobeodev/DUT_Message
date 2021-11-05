import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/widgets/chat/appbar.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarChat(),
        ],
      ),
      backgroundColor: Palette.lavenderSilver,
    );
  }
}
