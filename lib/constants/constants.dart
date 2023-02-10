import '../models/models.dart';
import 'application.dart';
import 'connection.dart';

class Constants {
  static ApplicationConstants applicationConstants = ApplicationConstants();
  static ConnectionConstants connectionConstants = ConnectionConstants();
  static const bool useAuth = true;
  static const bool devBuild = true;
  static const bool devConsole = false;
  static const bool debugBanner = false;
  static const bool useMock = true;
  static const String devAccessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzM2E1NDM5ZGM5YWQ0YzAzY2YwYzVkMCIsInR5cGUiOiJVU0VSIiwiaWF0IjoxNjY0NzY5NjM0fQ.XSpQuPmD0W_IZRyfdwMc_PPvBrAIFSSRch9gIE2VvwY';
  static final LoginAPIBody devUser = LoginAPIBody(
    username: 'user@sanchitdang.com',
    password: 'password',
  );
}
