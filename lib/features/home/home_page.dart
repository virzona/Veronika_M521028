import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/posts_cubit.dart';
import 'widgets/post_preview_card.dart';

class MyHomePage extends StatefulWidget {
   const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ScrollController scrollController;
  late final PostsCubit postsCubit;

  double currentPosition = 0.0;

  @override
  void initState() {
    scrollController = ScrollController()..addListener(listenScroll);
    postsCubit = PostsCubit(context.read())..init();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const SizedBox(
          height: 36,
          width: 120,
          child: Text('GrammyRu', style: TextStyle(fontFamily: 'DancingScript', fontSize: 30),),
        ),
        actions: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_box_outlined,
                  size: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite_outline_rounded,
                  size: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.energy_savings_leaf_outlined,
                  size: 30,
                ),
              ),
            ],
          )
        ],
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        bloc: postsCubit,
        builder: (context, state) {
          return switch (state) {
            PostsLoadedState() => ListView.builder(
                controller: scrollController,
                itemCount: state.postsInfo.data.length,
                prototypeItem: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PostPreviewCard(
                    postPreview: state.postsInfo.data.first,
                  ),
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: PostPreviewCard(
                      postPreview: state.postsInfo.data[index],
                    ),
                  );
                },
              ),
            _ => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(listenScroll);
  }

  void listenScroll() {
    if (scrollController.position.atEdge && scrollController.position.pixels == 0) {
      return;
    }
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      _loadNextPage();
    }
  }

  void _loadNextPage() async {
    // Save current scroll position
    currentPosition = scrollController.position.pixels;

    // Load the next page of data
    await postsCubit.nextPage();

    // Restore the scroll position after data is loaded
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollController.jumpTo(currentPosition);
    });
  }
}
