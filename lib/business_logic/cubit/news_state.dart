import 'package:flutter/material.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsBottomNavChanged extends NewsState {}

final class NewsGetBusinessSuccessState extends NewsState {}

final class NewsGetBusinessErrorState extends NewsState {
  final String error;
  NewsGetBusinessErrorState({required this.error});
}

final class NewsLoadingGetBusinessState extends NewsState {}

final class NewsGetScienceSuccessState extends NewsState {}

final class NewsGetScienceErrorState extends NewsState {
  final String error;
  NewsGetScienceErrorState({required this.error});
}

final class NewsLoadingGetScienceState extends NewsState {}

final class NewsGetSportsSuccessState extends NewsState {}

final class NewsGetSportsErrorState extends NewsState {
  final String error;
  NewsGetSportsErrorState({required this.error});
}

final class NewsLoadingGetSportsState extends NewsState {}
final class NewsGetSearchSuccessState extends NewsState {}

final class NewsGetSearchErrorState extends NewsState {
}

final class NewsLoadingGetSearchState extends NewsState {}




final class NewsChangeModeState extends NewsState {}