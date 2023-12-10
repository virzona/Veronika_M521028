import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_environtment/features/profile/widgets/profile_short_info.dart';
import 'package:image_picker/image_picker.dart';


class ProfileShortInfoState extends State<ProfileShortInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: _changeProfilePicture,
              child: ClipOval(
                child: widget.image.isNotEmpty
                    ? Image.network(
                  widget.image.first,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )
                    : Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      widget.imageUrls.length.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Посты',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '2357',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                Text(
                  'Подписчики',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 26.0),
              child: Column(
                children: [
                  Text(
                    '56',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  Text(
                    'Подписки',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                widget.nameController.text,
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
              padding: EdgeInsets.only(left: 8),
              child: Text(
                '🌺🌺🌺🌺🌺',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _changeProfilePicture() async {
    final picker1 = ImagePicker();
    final pickedFile2 = await picker1.getImage(source: ImageSource.gallery);

    if (pickedFile2 != null) {
      setState(() {
        widget.image.insert(0, pickedFile2.path);
        _saveImages2();
      });
    }
  }

  void _saveImages2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('image', widget.image);
  }
}