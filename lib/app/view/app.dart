import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/app_config.dart';
import 'package:kanban/core/router/app_router.dart';
import 'package:kanban/core/theme/app_theme.dart';
import 'package:kanban/l10n/arb/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConfig.appDimensions,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
