import 'package:frontend/router/router_path.dart';
import 'package:frontend/screens/campaign/campaign_screen.dart';
import 'package:frontend/screens/history/history_screen.dart';
import 'package:frontend/screens/intro/intro_screen.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/member/login_screen.dart';
import 'package:frontend/screens/ranking/ranking_screen.dart';
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
    ),
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: RoutePath.ranking,
      name: 'ranking',
      builder: (context, state) => RankingScreen(),
    ),
    GoRoute(
      path: RoutePath.history,
      name: 'history',
      builder: (context, state) => HistoryScreen(),
    ),
    GoRoute(
      path: RoutePath.campaign,
      name: 'campaign',
      builder: (context, state) => CampaignScreen(),
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
