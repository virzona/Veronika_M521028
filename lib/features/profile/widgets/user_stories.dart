import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'story_preview.dart';

class UserStories extends StatelessWidget {
  const UserStories({
    super.key,
    required this.stories,
  });

  final List stories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 18),
              child: Text(
                'Актуальное из историй',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 6.0, left: 18),
              child: Text(
                'Избранные истории',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            itemCount: stories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return StoryWidget(
                username: stories[index],
              );
            },
          ),
        ),
      ],
    );
  }
}