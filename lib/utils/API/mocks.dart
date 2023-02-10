import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:user_onboarding/constants/constants.dart';
import 'package:user_onboarding/models/dependants/api/api.dart';
import 'package:user_onboarding/utils/Logger/logger.dart';

class DioMockAdapterHelper {
  DioMockAdapterHelper._privateConstructor();
  bool _userLoggedIn = false;

  static final DioMockAdapterHelper _instance =
      DioMockAdapterHelper._privateConstructor();

  factory DioMockAdapterHelper(Dio dio) {
    _instance._dio = dio;
    return _instance;
  }

  late final Dio _dio;
  late DioAdapter dioMockAdapter = DioAdapter(dio: _instance._dio);

  void defineMocks() {
    if (Constants.useMock) {
      logger.i("Using Mocks");
      dioMockAdapter.onPost(
        'user/login',
        (server) {
          _userLoggedIn = true;
          server.reply(200, {
            "success": true,
            "data": {
              "accessToken": Constants.devAccessToken,
              "userDetails": {
                "_id": "633a5439dc9ad4c03cf0c5d0",
                "firstName": "Sanchit",
                "lastName": "Dang",
                "emailId": "test@user.com",
                "phoneNumber": "432781234",
                "initialPassword": "R3jXUPiUW0Ju",
                "firstLogin": false,
                "countryCode": "+61",
                "emailVerified": true,
                "isBlocked": false,
                "codeUpdatedAt": "2022-10-03T03:17:13.938Z"
              },
              "appVersion": {
                "latestIOSVersion": 100,
                "latestAndroidVersion": 100,
                "criticalAndroidVersion": 100,
                "criticalIOSVersion": 100
              }
            }
          });
        },
        data: {
          "deviceData": {
            'deviceName': 'MOCK_DEVICE',
            'deviceUUID': 'f15cdc5a-06ef-4c62-a5ff-bfc14cafcfc1',
            'deviceType': 'MOCK'
          },
          "emailId": "test@user.com",
          "password": "123456"
        },
      );

      dioMockAdapter.onPost(
        'user/accessTokenLogin',
        (server) {
          if (_userLoggedIn) {
            server.reply(200, {
              "success": true,
              "data": {
                "accessToken": "accessToken",
                "refreshToken": "refreshToken",
                "userDetails": {
                  "id": "id",
                  "name": "name",
                  "email": "email",
                  "phone": "phone",
                  "role": "role",
                  "createdAt": "createdAt",
                  "updatedAt": "updatedAt",
                  "firstLogin": true
                }
              }
            });
          } else {
            server.reply(401, {
              "success": false,
              "message": "Unauthorized",
              "error": "Unauthorized"
            });
          }
        },
      );

      dioMockAdapter.onGet('user/getProfile', (server) {
        server.reply(200, {
          "success": true,
          "data": UserProfileAPIResponseBody(
            countryCode: '+61',
            emailId: 'test@test.com',
            firstName: 'firstName',
            lastName: 'lastName',
            emailVerified: true,
            firstLogin: true,
            initialPassword: null,
            isBlocked: false,
            phoneNumber: '432734567',
            registrationDate: '2021-07-01T00:00:00.000Z',
            sId: 'sId',
          ).toJson()
        });
      });

      dioMockAdapter.onPut('user/changePassword', (server) {
        server.reply(200, {
          "success": true,
          "data": {
            "accessToken": "accessToken",
            "refreshToken": "refreshToken",
            "userDetails": {
              "id": "id",
              "name": "name",
              "email": "email",
              "phone": "phone",
              "role": "role",
              "createdAt": "createdAt",
              "updatedAt": "updatedAt",
              "firstLogin": true
            }
          }
        });
      }, data: {'newPassword': '', 'oldPassword': '', 'skip': true});
    }

    dioMockAdapter.onPut('user/logout', (server) {
      _userLoggedIn = false;
      server.reply(200, {
        "success": true,
        "data": {
          "accessToken": "accessToken",
          "refreshToken": "refreshToken",
          "userDetails": {
            "id": "id",
            "name": "name",
            "email": "email",
            "phone": "phone",
            "role": "role",
            "createdAt": "createdAt",
            "updatedAt": "updatedAt",
            "firstLogin": true
          }
        }
      });
    });
  }
}
