import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/theme/theme_data.dart';

class ThemeCubit extends Cubit<ThemeData>{
  ThemeCubit() : super(AppTheme.lightTheme);

  void toogleTheme(){
    emit(state == AppTheme.lightTheme ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}