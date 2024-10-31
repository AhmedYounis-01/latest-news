import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_todo_app/business_logic/cubit/news_cubit.dart';
import 'package:sqflite_todo_app/business_logic/cubit/news_state.dart';
import 'package:sqflite_todo_app/presentation/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NewsCubit, NewsState>(
        // استخدم BlocBuilder بدلاً من BlocConsumer هنا
        builder: (context, state) {
          var list = NewsCubit.get(context).search;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: searchController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(list, context, isSearch: true),
              ),
            ],
          );
        },
      ),
    );
  }
}
