import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shopping/data/repository/init_Repository.dart';
import 'package:meta/meta.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitInitial());

  static final repository = InitRepository();

  get client => repository.getClient;
}
