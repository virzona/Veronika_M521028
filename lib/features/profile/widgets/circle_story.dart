import 'package:flutter/material.dart';

class CircleStory extends StatelessWidget {
  const CircleStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(6.0),
      child: ClipOval(
        child: Image(
          height: 68,
          width: 68,
          image: NetworkImage(
              'https://pixelbox.ru/wp-content/uploads/2022/01/avatar-estetik-krasota-pixelbox.ru-89.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}