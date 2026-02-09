import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/core/di/service_injector.dart';
import 'package:shop_project/core/di/service_locator.dart';
import 'package:shop_project/core/localization/l10n/app_localizations.dart';
import 'package:shop_project/core/navigation/app_router.dart';
import 'package:shop_project/core/theme/theme_cubit.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/email/bloc/email_bloc.dart';
import 'package:shop_project/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shop_project/features/product/presentation/cubit/selected_product_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/localization/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://itkrislbdpxnudoghdnq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0a3Jpc2xiZHB4bnVkb2doZG5xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk5OTcxOTYsImV4cCI6MjA4NTU3MzE5Nn0._8CteS8AsQxu6ONO58C93ctooy9WpFTWf6abgJjK7eY',
  );
  
  initServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageManager = context.watch<LanguageManager>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator.get<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator.get<EmailBloc>()),
        BlocProvider(create: (context) => serviceLocator.get<CartBloc>()),
        BlocProvider(create: (context) => SelectedProductCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: serviceLocator.get<AppRouter>().router,
            theme: context.watch<ThemeCubit>().state,
            locale: languageManager.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (final supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            builder: (context, child) {
              final isRTL = languageManager.locale.languageCode == 'ar';

              return Directionality(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeManager = context.watch<AppThemeManager>();
    
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
      
//       // Theme
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: themeManager.themeMode,
      
//       // Localization
//       locale: context.watch<LanguageManager>().locale,
//       supportedLocales: AppLocalizations.supportedLocales,
//       localizationsDelegates: const [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       localeResolutionCallback: (locale, supportedLocales) {
//         for (var supportedLocale in supportedLocales) {
//           if (supportedLocale.languageCode == locale?.languageCode) {
//             return supportedLocale;
//           }
//         }
//         return supportedLocales.first;
//       },
      
//       builder: (context, child) {
//         return Consumer<LanguageManager>(
//           builder: (context, languageManager, child) {
//             final isRTL = languageManager.locale.languageCode == 'ar';
            
//             return Directionality(
//               textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
//               child: child!,
//             );
//           },
//           child: child,
//         );
//       },
      
//       home: const SplashScreen(),
//     );
//   }
// }