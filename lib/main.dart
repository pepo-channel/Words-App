import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, MultiBlocProvider;
import 'package:hive_flutter/adapters.dart';
import 'package:word_app/core/consts.dart';
import 'package:word_app/cubits/read%20cubit/cubit/read_word_cubit.dart';
import 'package:word_app/cubits/write%20cubit/cubit/write_word_cubit.dart';
import 'package:word_app/features/home/screens/home_screen.dart';
import 'package:word_app/models/word_typeadapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeadapter());
  await Hive.openBox(kHiveBox);
  runApp(const WordApp());
}

class WordApp extends StatelessWidget {
  const WordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReadWordCubit(),
        ),
        BlocProvider(
          create: (context) => WriteWordCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: colorsdata.BaisicColor,
          primaryTextTheme: TextTheme(
            bodyLarge: TextStyle(color: colorsdata.WhiteColor, fontWeight: FontWeight.bold, fontSize: 25,),
            bodyMedium: TextStyle(color: colorsdata.WhiteColor, fontWeight: FontWeight.w500, fontSize: 20,),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}