import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_todo_app/business_logic/cubit/news_cubit.dart';
import 'package:sqflite_todo_app/business_logic/cubit/news_state.dart';
import 'package:sqflite_todo_app/presentation/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          return articleBuilder(list ,context);
        });
  }
}
