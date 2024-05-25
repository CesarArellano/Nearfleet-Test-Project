import 'package:flutter/material.dart';

class EmptyFullScreen extends StatelessWidget {
  
  const EmptyFullScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final size = (deviceWidth > 800) ? deviceWidth * 0.5 : deviceWidth * 0.9;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset('assets/images/empty_list_image.png', width: size)
          ),
        ),
        const Text('No addresses registered', style: TextStyle(fontSize: 18.0),)
      ],
    );
  }
}