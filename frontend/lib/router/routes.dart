import 'package:frontend/router/router_path.dart';
import 'package:frontend/screens/intro/intro_screen.dart';
import 'package:frontend/screens/member/login_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter globalRouter = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.login,
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RoutePath.intro,
      name: 'intro',
      builder: (context, state) => IntroScreen(),
    )
    // GoRoute(
    //   path: RoutePath.main,
    //   name: 'main',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id'];
    //     final bookId = state.pathParameters['bookId'];
    //     return MainScreen(id: id ?? '0', bookId: bookId ?? '0');
    //   },
    // ),
  ],
  initialLocation: RoutePath.login,
);
