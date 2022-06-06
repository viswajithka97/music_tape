import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'favouriteicon_state.dart';

class FavouriteiconCubit extends Cubit<FavouriteiconState> {
  FavouriteiconCubit() : super(FavouriteiconInitial());
}
