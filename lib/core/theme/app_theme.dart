
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_project/core/theme/theme_cubit.dart';
// import 'package:shop_project/core/theme/theme_data.dart';

// class AppThemeManager with ChangeNotifier{
//   ThemeMode _themeMode = ThemeMode.light;

//   ThemeMode get themeMode => _themeMode;
//   ThemeData get currentTheme => _themeMode == ThemeMode.dark 
//       ? AppTheme.darkTheme 
//       : AppTheme.lightTheme;
  
//   bool get isDarkMode => _themeMode == ThemeMode.dark;

//   void toogleTheme(){
//     _themeMode = _themeMode == ThemeMode.light
//       ? ThemeMode.dark
//       : ThemeMode.light;
//     notifyListeners();
//   }

//   void setTheme(ThemeMode mode){
//     _themeMode = mode;
//     notifyListeners();
//   }
// }

// extension ThemeExtensions on BuildContext {
//   // AppThemeManager get themeManager => 
//   //     Provider.of<AppThemeManager>(this, listen: false);
//   ThemeCubit get themeCubit => read<ThemeCubit>();
  
//   ThemeData get theme => Theme.of(this);
//   ColorScheme get colors => theme.colorScheme;
//   TextTheme get texts => theme.textTheme;
// }