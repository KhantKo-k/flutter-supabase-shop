import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/core/localization/l10n/app_localizations.dart';
import 'package:shop_project/core/localization/localization.dart';
import 'package:shop_project/core/theme/color_palette.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final localProvider = context.watch<LanguageManager>();
    final currentLocale = localProvider.locale;

    return PopupMenuButton<Locale>(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, color: AppColors.primary),
          const SizedBox(width: 4),
          // Text(
          //   currentLocale.languageCode.toUpperCase(),
          //   style: TextStyle(
          //     color: AppColors.secondary,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
        ],
      ),
      itemBuilder: (context) => AppLocalizations.supportedLocales
          .map(
            (locale) => PopupMenuItem(
              value: locale,
              child: Row(
                children: [
                  if (locale.languageCode == currentLocale.languageCode)
                    Icon(Icons.check, color: AppColors.primary, size: 20)
                  else
                    const SizedBox(width: 20),

                  const SizedBox(width: 8),
                  Text(locale.languageCode.toUpperCase()),
                ],
              ),
            ),
          )
          .toList(),
      onSelected: (locale) {
        localProvider.setLocale(locale);
      },
    );
  }
}
