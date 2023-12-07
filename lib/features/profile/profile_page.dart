import 'package:flutter/material.dart';
import 'package:test_environtment/features/profile/widgets/circle_story.dart';
import 'package:test_environtment/features/profile/widgets/story_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Объявление виджета ProfileScreen, который является состоянием (stateful) и наследует от StatefulWidget
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

//Определение приватного состояния для виджета ProfileScreen,
// включая список историй (_stories), контроллер имени (_nameController) и
// список URL изображений (_imageUrls)
class _ProfileScreenState extends State<ProfileScreen> {
  final List _stories = [
    'История 1',
    'История 2',
    'История 3',
    'История 4',
    'История 5'
  ];
  late TextEditingController _nameController;
  List<String> _imageUrls = [];
//Переопределение метода build, который строит и отображает UI виджета
// Создание виджета DefaultTabController, который предоставляет вкладки (Tabs) для отображения контента в разных разделах экрана
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
              _nameController.text,
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
                      onPressed: _addImage,
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
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10),
                    child: ClipOval(
                      child: Image(
                        height: 80,
                        width: 80,
                        image: NetworkImage(
                            'https://pixelbox.ru/wp-content/uploads/2022/01/avatar-estetik-krasota-pixelbox.ru-89.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            _imageUrls.length.toString(),
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
                    padding: EdgeInsets.only(left: 26),
                    child: Text(
                      _nameController.text,
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
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      '🌺🌺🌺🌺🌺',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
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
                      )),
                ],
              ),
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
                    itemCount: _stories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return StoryWidget(
                        username: _stories[index],
                      );
                    }),
              ),

              const TabBar(tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.video_collection_outlined),
                ),
                Tab(
                  icon: Icon(Icons.person_add_alt_outlined),
                ),
              ]),

              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    GridView.count(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(4),
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      crossAxisCount: 3,
                      children: _imageUrls.map((imageUrl) {
                        return _buildImageContainer(imageUrl);
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
        ));
  }

  //Переопределение метода initState, который вызывается при создании объекта состояния
  // В данном случае, инициализируются контроллер имени и загружаются данные из хранилища (например, SharedPreferences)
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadUserName();
    _loadImages();
  }

  //Метод _loadUserName, который асинхронно загружает имя пользователя из хранилища и обновляет состояние
  void _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('userName');
    setState(() {
      _nameController.text = savedName ?? 'Name';
    });
  }

  //Метод _loadImages, который асинхронно загружает URL изображений из хранилища и обновляет состояние
  void _loadImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrls = prefs.getStringList('imageUrls') ?? [];
    });
  }

  //Метод _editProfile, который открывает диалоговое окно для редактирования профиля и обрабатывает новое имя
  void _editProfile() async {
    final newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактирование профиля'),
          content: TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Новое имя'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, _nameController.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (newName != null && newName.isNotEmpty) {
      _saveUserName(newName); // Сохраняем новое имя при сохранении
    }
  }

  //Метод _saveUserName, который асинхронно сохраняет новое имя пользователя в хранилище
  void _saveUserName(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', newName);
    setState(() {
      _nameController.text = newName;
    });
  }

  //Метод _saveImages, который асинхронно сохраняет список URL изображений в хранилище
  void _saveImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('imageUrls', _imageUrls);
  }

  //Метод _addImage, который открывает диалоговое окно для добавления изображения и обрабатывает добавленный URL
  void _addImage() async {
    TextEditingController imageUrlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить изображение'),
          content: TextFormField(
            controller: imageUrlController,
            decoration: const InputDecoration(labelText: 'Ссылка на изображение'),
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
          _imageUrls.add(imageUrl);
          _saveImages(); // Сохраняем обновленный список изображений
        });
      }
    });
  }

  //Метод _buildImageContainer, который возвращает виджет контейнера с изображением для отображения в сетке
  Widget _buildImageContainer(String imageUrl) {
    return InkWell(
      onTap: () {
        _showFullScreenImage(imageUrl);
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Image(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //Метод _showFullScreenImage, который открывает диалоговое окно с полноразмерным изображением.
  void _showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
