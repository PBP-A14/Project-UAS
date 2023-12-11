import 'package:elibrary/common/appbar_theme.dart';
import 'package:elibrary/common/inputdecoration_theme.dart';
import 'package:elibrary/data/api/progress_api_service.dart';
import 'package:elibrary/navigation_menu.dart';
import 'package:elibrary/pages/authentication/login_page.dart';
import 'package:elibrary/pages/authentication/register_page.dart';
import 'package:elibrary/pages/home/book_list_page.dart';
import 'package:elibrary/pages/home/home_page.dart';
import 'package:elibrary/pages/home/search_page.dart';
import 'package:elibrary/provider/home_provider.dart';
import 'package:elibrary/provider/progress_provider.dart';
import 'package:elibrary/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'auth/auth.dart';
import 'data/api/home_api_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ProgressProvider(apiService: ProgressApiService())
        ),
        Provider(
          create: (_) {
            CookieRequest request = CookieRequest();
            return request;
          },
        ),
      ],
      child: MaterialApp(
        title: 'eLibrary',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF1F2F4),
          appBarTheme: myAppbarTheme,
          inputDecorationTheme: myInputDecoration,
        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: LoginPage.routeName,
        home: LoginPage(),
        routes: {
          NavigationMenu.routeName: (context) => NavigationMenu(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            // case NavigationMenu.routeName:
            //   return MaterialPageRoute(
            //     builder: (context) => const NavigationMenu(),
            //   );
            case HomePage.routeName:
              return MaterialPageRoute(
                builder: (context) => const HomePage(),
              );
            case SearchPage.routeName:
              return PageTransition(
                type: PageTransitionType.fade,
                child: const SearchPage(),
              );
            case BookListPage.routeName:
              return PageTransition(
                type: PageTransitionType.bottomToTop,
                child: const BookListPage(),
              );
            case LoginPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const LoginPage(),
              );
            case RegisterPage.routeName:
              return PageTransition(
                type: PageTransitionType.fade,
                child: const RegisterPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const LoginPage(),
              );
          }
        },
      ),
    );
  }
}
