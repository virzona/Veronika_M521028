import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_environtment/data/remote_data_sources/profile/profile_data_source.dart';
import 'package:test_environtment/domain/models/user_preview.dart';
import 'package:test_environtment/features/home/bloc/posts_cubit.dart';
import 'package:test_environtment/features/profile/widgets/profile_short_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileShortInfoState extends State<ProfileShortInfo> {
  late final ProfileDataSource profileDataSource;
  late UserPreview user;
  final picker = ImagePicker();
  String Photo = "...";
  XFile? image;

  XFile? get imageProfile => image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  pickImage(context);
                },
                child: ClipOval(
                    child: Image.network(
                  Photo,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ))),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      '50',
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
                widget.nikname,
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

  @override
  void initState() {
    super.initState();
    profileDataSource = context.read<ProfileDataSource>();
    init();
  }

  Future<void> init() async {
    final usersInfo = await profileDataSource.getProfiles();
    user = usersInfo.data[10];
    Photo = user.picture;
    setState(() {});
  }

  Future<void> updateUserPhoto({required String photo}) async {
    final updatedUser = await profileDataSource.updateProfileUserPhoto(
        profileId: user.id, userPicture: photo);
    Photo = updatedUser.picture;
    setState(() {});
  }

  Future pickGalleryImage() async {
    TextEditingController imageUrlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить изображение'),
          content: TextFormField(
            controller: imageUrlController,
            decoration:
                const InputDecoration(labelText: 'Ссылка на изображение'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (imageUrlController.text.isNotEmpty) {
                  Navigator.pop(context, imageUrlController.text);
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    ).then((imageUrl) {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        setState(() {
          updateUserPhoto(photo: imageUrl);
        });
      }
    });
    // final pickedFile =
    //     await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    // if (pickedFile != null) {
    //   image = XFile(pickedFile.path);
    //   updateUserPhoto(photo: image!.path);
    // }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      image = XFile(pickedFile.path);
      updateUserPhoto(photo: image!.path);
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                  title: Text('Камера'),
                ),
                ListTile(
                  onTap: pickGalleryImage,
                  leading: Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                  title: Text('Галерея'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
