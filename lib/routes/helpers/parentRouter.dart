import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_onboarding/constants/constants.dart';
import 'package:user_onboarding/utils/Logger/logger.dart';
export 'package:go_router/go_router.dart';

import '../../providers/providers.dart';
import '../../widgets/common/common.dart';
import '../../screens/screens.dart';
import '../../models/models.dart';

class RouterTemplate {}

class ParentRouter {
  late final GoRouter router;

  final RouteConfig _defaultRoute = RouteConfig(
    route: WelcomePage.route,
    type: RouteType.UN_AUTHENTICATED,
    widget: const WelcomePage(),
  );

  RouteConfig get defaultRoute => _defaultRoute;

  List<RouteConfig> extraRoutes = [];

  final List<RouteConfig> _routes = [
    RouteConfig(
      route: Login.route,
      type: RouteType.UN_AUTHENTICATED,
      widget: Login(),
    ),
    RouteConfig(
      route: WelcomePage.route,
      type: RouteType.UN_AUTHENTICATED,
      widget: const WelcomePage(),
    ),
    RouteConfig(
      route: LoadingScreen.route,
      type: RouteType.UN_AUTHENTICATED,
      widget: const LoadingScreen(),
    ),
    RouteConfig(
      route: SignUp.route,
      type: RouteType.UN_AUTHENTICATED,
      widget: const SignUp(),
    ),
    RouteConfig(
      route: Home.route,
      type: RouteType.AUTHENTICATED,
      widget: const Home(),
    ),
    RouteConfig(
      route: ChangePassword.route,
      type: RouteType.AUTHENTICATED,
      widget: const ChangePassword(),
    ),
    RouteConfig(
      route: DevEnvironment.route,
      type: RouteType.AUTHENTICATED,
      widget: const DevEnvironment(),
    ),
  ];

  String? _pleaseRedirectTo(String route, GoRouterState state) {
    if (state.location != route) {
      return route;
    }
    return null;
  }

  Future<String?> _redirect(List<RouteConfig> routes, BuildContext context,
      GoRouterState state) async {
    if (Provider.of<UserStateProvider>(context, listen: false).loginStatus) {
      UserProfileProvider userProfileState =
          Provider.of<UserProfileProvider>(context, listen: false);
      //user's logged in
      if (userProfileState.userProfile == null) {
        await userProfileState.getUserProfile();
      }
      if (userProfileState.userProfile!.firstLogin == false &&
          state.location != ChangePassword.route) {
        logger.d('Redirecting to change password');
        return _pleaseRedirectTo(ChangePassword.route, state);
      }
      if (Constants.devConsole) {
        logger.d('Redirecting to DevEnvironment');
        return _pleaseRedirectTo(DevEnvironment.route, state);
      }
      return null;
    } else {
      if (state.location != WelcomePage.route &&
          state.location != Login.route &&
          state.location != SignUp.route) {
        return WelcomePage.route;
      }
    }
    return null;
  }

  void initialize() {
    if (extraRoutes.isNotEmpty) {
      _routes.addAll(extraRoutes);
    }
    _routes.add(defaultRoute);
    router = GoRouter(
      initialLocation: defaultRoute.route,
      routes: _routes.map((route) {
        return GoRoute(
            path: route.route,
            pageBuilder: (context, state) {
              return MaterialPage(child: route.widget);
            });
      }).toList(),
      errorBuilder: (context, state) {
        logger.e(state.error);
        return const Four0Four(
          isInitialLoading: true,
          redirectionDuration: Duration(milliseconds: 1000),
        );
      },
      redirect: (context, state) => _redirect(_routes, context, state),
    );
  }

  GoRouter get appRouter => router;

  List<RouteConfig> get routes => _routes;
}
