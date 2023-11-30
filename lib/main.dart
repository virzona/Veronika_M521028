import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_environtment/core/di/app_services.dart';
import 'package:test_environtment/features/profile/profile_page.dart';

import 'configuration/environment/environment.dart';
import 'core/app.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

// void main() {
//   final appServices = AppServices(
//     dio: Dio(Environment.baseDioOptions),
//   );
//
//   runZonedGuarded(
//         () => runApp(
//       MyApp(
//         appServices: appServices,
//       )
//     ),
//         (error, stack) {
//       log('$error', stackTrace: stack);
//     },
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const GrammyRu(),
    );
  }
}

class GrammyRu extends StatefulWidget {
  const GrammyRu({Key? key}) : super(key: key);

  @override
  State<GrammyRu> createState() => _GrammyRuState();
}

class _GrammyRuState extends State<GrammyRu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: const [
                  Icon(Icons.lock_outline),
                  Text("Nickname"),
                  Icon(Icons.keyboard_arrow_down_outlined),
                ],
              ),
            ),
            Container(
              child: Row(
                children: const [
                  Icon(Icons.add_box_outlined),
                  Icon(Icons.menu),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 45,
                ),
                Column(
                  children: [
                    Text(
                      '135',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text('Публикации'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '2513',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text('Подписчики'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '56',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text('Подписки'),
                  ],
                )
              ],
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text("Nickname", style: TextStyle(fontSize: 20),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {},
                  child: Text("Изменить", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white),),
                ElevatedButton(onPressed: () {},
                    child: Text("Поделиться профилем",
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white)),
                ElevatedButton(
                    onPressed: () {}, child: Icon(Icons.person_add_outlined)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white, radius: 32,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("Name stories")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.grid_on_outlined, size: 30,),
                Icon(Icons.person_pin_outlined, size: 30,),
              ],
            ),
            GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );

  }
}
