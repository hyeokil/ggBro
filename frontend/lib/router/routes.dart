import 'package:frontend/router/router_path.dart';
import 'package:frontend/screens/campaign/campaign_screen.dart';
import 'package:frontend/screens/history/history_screen.dart';
import 'package:frontend/screens/intro/intro_screen.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/member/login_screen.dart';
import 'package:frontend/screens/member/signup_screen.dart';
import 'package:frontend/screens/plogging/ready_plogging.dart';
import 'package:frontend/screens/profile/profile_screen.dart';
import 'package:frontend/screens/ranking/ranking_screen.dart';
import 'package:frontend/screens/rescue/rescue_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter globalRouter = GoRouter(
  routes: [
    GoRoute(
        path: RoutePath.singUp,
        name: 'singup',
        builder: (context, state) => const SignUpScreen()),
    GoRoute(
      path: RoutePath.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePath.intro,
      name: 'intro',
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: RoutePath.ranking,
      name: 'ranking',
      builder: (context, state) => const RankingScreen(),
    ),
    GoRoute(
      path: RoutePath.history,
      name: 'history',
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: RoutePath.campaign,
      name: 'campaign',
      builder: (context, state) => const CampaignScreen(),
    ),
    GoRoute(
      path: RoutePath.ploggingReady,
      name: 'ploggingReady',
      builder: (context, state) => const ReadyPlogging(),
    ),
    GoRoute(
      path: RoutePath.profile,
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: RoutePath.rescue,
      name: 'rescue',
      builder: (context, state) => const RescueScreen(),
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
