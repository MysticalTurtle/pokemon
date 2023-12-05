import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/domain/bloc/home_bloc.dart';
import 'core/theme/app_colors.dart';
import 'injection_container.dart';
import 'presentation/home/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Hive.initFlutter();
  // await Hive.openBox<String>('pokedex');

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await di.init();
  runApp(BlocProvider<HomeBloc>(
    create: (_) => sl<HomeBloc>()..add(HomeFetchPokemons()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}
