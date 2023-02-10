import 'package:flutter/material.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfileAPIResponseBody? _userProfile;

  UserProfileAPIResponseBody? get userProfile => _userProfile;

  Future<UserProfileAPIResponseBody?> getUserProfile() async {
    DIOResponseBody response = await API().getProfile();
    if (response.success) {
      _userProfile = UserProfileAPIResponseBody.fromJson(response.data);
    }
    notifyListeners();
    return _userProfile;
  }
}
