import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_todo_app/business_logic/cubit/bloc_observer.dart';
import 'package:sqflite_todo_app/business_logic/cubit/news_cubit.dart';
import 'package:sqflite_todo_app/business_logic/cubit/news_state.dart';
import 'package:sqflite_todo_app/data/local/cache_helper.dart';
import 'package:sqflite_todo_app/data/remote/dio_helper.dart';
import 'package:sqflite_todo_app/presentation/components/theme_data.dart';
import 'package:sqflite_todo_app/presentation/layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDart');
  // using a Default to light mode
  isDark ??= false;
  // if (isDark == null) {
  //   isDark = false;
  // }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HomeLayout(),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme(),
            darkTheme: darkTheme(),
          );
        },
      ),
    );
  }
}
