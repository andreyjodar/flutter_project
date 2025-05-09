import 'package:flutter/material.dart';
import 'package:flutter_app_1/settings/routes.dart';
import 'package:flutter_app_1/widgets/widget_about.dart';
import 'package:flutter_app_1/widgets/widget_home.dart';
import 'package:flutter_app_1/widgets/widget_new_research.dart';
import 'package:flutter_app_1/widgets/widget_profile.dart';
import 'package:flutter_app_1/widgets/widget_research.dart';
import 'package:flutter_app_1/widgets/widget_search.dart';

class App extends StatelessWidget {
  const App({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Routes.home,
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.home: (context) => const WidgetHome(),
          Routes.search: (context) => WidgetSearch(),
          Routes.research: (context) => WidgetResearch(),
          Routes.newResearch: (context) => WidgetNewResearch(),
          Routes.profile: (context) => WidgetProfile(),
          Routes.about: (context) => WidgetAbout()
        });
  }
}
