import 'package:appyhigh_assignment_flutter/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/theme_bloc.dart';
import 'ui/music_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(builder: (context, notifier, child) {
        return MaterialApp(
          title: 'Flutter Music Application',
          debugShowCheckedModeBanner: false,
          theme: notifier.theme,
          home: Scaffold(
            body: MusicList(),
          ),
        );
      }),
    );
  }
}
