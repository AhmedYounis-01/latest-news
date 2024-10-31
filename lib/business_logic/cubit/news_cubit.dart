import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_todo_app/business_logic/cubit/news_state.dart';
import 'package:sqflite_todo_app/data/local/cache_helper.dart';
import 'package:sqflite_todo_app/data/remote/dio_helper.dart';
import 'package:sqflite_todo_app/presentation/screens/business_screen.dart';
import 'package:sqflite_todo_app/presentation/screens/science_screen.dart';
import 'package:sqflite_todo_app/presentation/screens/setting_screen.dart';
import 'package:sqflite_todo_app/presentation/screens/sport_screen.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball_outlined,
      ),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
    const SettingScreen(),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavChanged());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsLoadingGetBusinessState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'e01f0ca094f2455e88112079eea09108',
    }).then(
      (value) {
        business = value.data['articles'];
        Logger().f(business[1]['title']);
        emit(NewsGetBusinessSuccessState());
      },
    ).catchError((error) {
      Logger().f("the error is: >> ${error.toString()}");
      emit(NewsGetBusinessErrorState(error: error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsLoadingGetSportsState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'sports',
      'apiKey': 'e01f0ca094f2455e88112079eea09108',
    }).then(
      (value) {
        sports = value.data['articles'];
        Logger().f(sports[1]['title']);
        emit(NewsGetSportsSuccessState());
      },
    ).catchError((error) {
      Logger().f("the error is: >> ${error.toString()}");
      emit(NewsGetSportsErrorState(error: error.toString()));
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsLoadingGetScienceState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'science',
      'apiKey': 'e01f0ca094f2455e88112079eea09108',
    }).then(
      (value) {
        science = value.data['articles'];
        Logger().f(science[1]['title']);
        emit(NewsGetScienceSuccessState());
      },
    ).catchError((error) {
      Logger().f("the error is: >> ${error.toString()}");
      emit(NewsGetScienceErrorState(error: error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsLoadingGetSearchState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'e01f0ca094f2455e88112079eea09108',
      },
    ).then((response) {
      search = response.data['articles'];
      emit(
          NewsGetSearchSuccessState()); // تأكد من تحديث الحالة بعد تغيير `search`
    }).catchError((error) {
      emit(NewsGetSearchErrorState());
    });
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDart', value: isDark).then(
        (value) {
          emit(NewsChangeModeState());
        },
      );
    }
  }
}
