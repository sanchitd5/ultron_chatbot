// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models.dart';
import '../helpers/parentRouter.dart';
import '../../screens/screens.dart';

class EC2Router extends ParentRouter {
  final BuildContext appContext;

  @override
  RouteConfig defaultRoute = RouteConfig(
      route: '/', widget: const Home(), type: RouteType.UN_AUTHENTICATED);

  EC2Router(this.appContext);

  Future<String> get accessToken async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('accessToken')) return '';
    var token = prefs.getString('accessToken');
    return token ?? '';
  }
}
