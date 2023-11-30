import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_environtment/configuration/navigation/app_roter_configuration.dart';

class AppRouterWidget extends StatefulWidget {
  const AppRouterWidget({super.key});

  @override
  State<AppRouterWidget> createState() => _AppRouterWidgetState();
}

class _AppRouterWidgetState extends State<AppRouterWidget> {
  late GoRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouterConfiguration.createRouter(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GrammyRu',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue.shade300,
      ),
    );
  }
}