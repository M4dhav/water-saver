import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_saver/controllers/app_user_controller.dart';
import 'package:water_saver/models/app_user.dart';

final appUserControllerProvider =
    AsyncNotifierProvider<AppUserController, AppUser>(() {
  return AppUserController();
});
