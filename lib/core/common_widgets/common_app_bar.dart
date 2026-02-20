import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/core/common_widgets/language_selector.dart';
import 'package:shop_project/core/theme/color_palette.dart';
import 'package:shop_project/core/theme/theme_cubit.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_bloc.dart';
import 'package:shop_project/features/auth/presentation/password/bloc/auth_event.dart';

// class CommonSilverAppBar extends StatelessWidget {
//   final String title;
//   final List<Widget>? extraActions;

//   const CommonSilverAppBar({super.key, required this.title, this.extraActions});

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       expandedHeight: 100.0,
//       pinned: true,
//       stretch: true,
//       backgroundColor: Theme.of(context).primaryColor,
//       elevation: 0,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
//       ),
//       centerTitle: true,
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//       actions: [
//         ...?extraActions,
//         IconButton(
//           onPressed: () => context.read<ThemeCubit>().toogleTheme(),
//           icon: const Icon(Icons.brightness_6),
//         ),
//         const LanguageSelector(), // Add your selector here
//         IconButton(
//           onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
//           icon: const Icon(Icons.logout),
//         ),
//       ],
//     );
//   }
// }

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      //backgroundColor: AppColors.primary,
      actions: [
        IconButton(
          onPressed: () => context.read<ThemeCubit>().toogleTheme(), // Fixed typo: toogleTheme -> toggleTheme
          icon: const Icon(Icons.brightness_6),
        ),
        const LanguageSelector(),
        IconButton(
          onPressed: () {
            print('pressing log out');
            context.read<AuthBloc>().add(LogoutRequested());
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}