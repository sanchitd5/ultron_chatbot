import 'package:flutter/material.dart';
import 'package:user_onboarding/utils/API/api.dart';
import 'package:user_onboarding/utils/API/mocks.dart';

import 'constants/constants.dart';
import 'providers/providers.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late EC2Router routerInstance;
  bool routerInitialized = false;

  @override
  void initState() {
    super.initState();
    routerInstance = EC2Router(context);
    routerInstance.initialize();
    if (Constants.useMock) {
      DioMockAdapterHelper(API().dioInstance.instance).defineMocks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Global Providers used by the application
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProfileProvider(),
        ),
      ],
      builder: (context, child) {
        return FutureBuilder(
            future: Provider.of<UserStateProvider>(context).accessTokenLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return MaterialApp.router(
                // controls the debug banner for the application
                debugShowCheckedModeBanner: Constants.debugBanner,
                title: Constants
                    .applicationConstants.title, // title for the application
                theme:
                    ApplicationTheme(context).getAppTheme, // application theme
                routerConfig:
                    routerInstance.router, // application screen routes
              );
            });
      },
    );
  }
}
