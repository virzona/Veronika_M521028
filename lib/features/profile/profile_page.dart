import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_environtment/data/remote_data_sources/profile/profile_data_source.dart';
import 'package:test_environtment/features/profile/widgets/profile_short_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/models/user_preview.dart';
import 'widgets/user_stories.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final List stories = [
    'История 1',
    'История 2',
    'История 3',
    'История 4',
    'История 5',
    'История 6',
    'История 7',
    'История 8',
    'История 9',
    'История 10'
  ];
  late final ProfileDataSource profileDataSource;
  late TabController tabController;
  TextEditingController nameController = TextEditingController();
  String nikname = "...";
  late UserPreview user;
  List<String> imageUrls = [];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            nikname,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: 30,
                    ),
                    onPressed: addImage,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.table_rows_rounded,
                    size: 30,
                  ),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              sliver: SliverToBoxAdapter(
                child: ProfileShortInfo(
                  imageUrls: imageUrls,
                  nikname: nikname,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 32,
                          width: 330,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () => _editProfile(),
                            child: Center(
                              child: Text(
                                'Редактировать профиль',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                            child: Icon(
                              Icons.person_add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: UserStories(stories: stories),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.video_collection_outlined)),
                  Tab(icon: Icon(Icons.person_add_alt_outlined)),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: tabController,
                children: [
                  GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(4),
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: 3,
                    children: imageUrls.map((imageUrl) {
                      return buildImageContainer(imageUrl);
                    }).toList(),
                  ),
                  Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Icon(
                          Icons.person_add,
                          color: Colors.black,
                          size: 60,
                        ),
                        Text(
                          "Фотографии и видео с Вами",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageContainer(String imageUrl) {
    return InkWell(
      onTap: () {
        showFullScreenImage(imageUrl);
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Image(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteImage(imageUrl);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    profileDataSource = context.read<ProfileDataSource>();
    init();
    loadImages();
  }

  Future<void> init() async {
    final usersInfo = await profileDataSource.getProfiles();
    user = usersInfo.data[10];
    nikname = user.firstName;
    setState(() {});
  }

  Future<void> update({required String name}) async {
    final updatedUser = await profileDataSource.updateProfile(profileId: user.id, name: name);
    nikname = updatedUser.firstName;
    setState(() {});
  }

  void loadImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      imageUrls = prefs.getStringList('imageUrls') ?? [];
    });
  }

  void _editProfile() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактирование профиля'),
          content: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Новое имя'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: ()
              {
                update(name: nameController.text);
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void saveImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('imageUrls', imageUrls);
  }

  void addImage() async {
    TextEditingController imageUrlController = TextEditingController();
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      setState(() {
        imageUrls.add(pickedFile.path);
        saveImages();
      });
    }
  }

  void _deleteImage(String imageUrl) {
    setState(() {
      imageUrls.remove(imageUrl);
      saveImages();
    });
  }

  void showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
