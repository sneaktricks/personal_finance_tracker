import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/pages/add_entry_page.dart';
import 'package:personal_finance_tracker/src/pages/add_expense_page.dart';
import 'package:personal_finance_tracker/src/pages/add_income_page.dart';
import 'package:personal_finance_tracker/src/pages/home_page.dart';
import 'package:personal_finance_tracker/src/pages/page_base.dart';
import 'package:personal_finance_tracker/src/pages/transaction_page.dart';
import 'package:personal_finance_tracker/src/pages/transactions_page.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return GetMaterialApp(
      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData.light(useMaterial3: true),
      // darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: "/",

      getPages: [
        GetPage(name: "/", page: () => PageBase(child: HomePage())),
        GetPage(name: "/add-entry", page: () => AddEntryPage()),
        GetPage(name: "/add-entry/income", page: () => AddIncomePage()),
        GetPage(name: "/add-entry/expense", page: () => AddExpensePage()),
        GetPage(name: "/transactions", page: () => TransactionsPage()),
        GetPage(name: "/transactions/:id", page: () => TransactionPage()),
      ],

      // builder: (context, child) {
      //   return Obx(() {
      //     return PageBase(child: child!);
      //   });
      // },
    );
  }
}
