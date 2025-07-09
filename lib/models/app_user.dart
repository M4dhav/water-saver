import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:water_saver/models/user_data_receive.dart';
import 'package:water_saver/models/user_data_upload.dart';
import 'package:water_saver/models/user_profile.dart';

part 'generated/app_user.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  factory AppUser(
    String deviceId,
    UserDataUpload userDataUpload,
    UserProfile userProfile,
    UserDataReceive userDataReceive,
  ) = _AppUser;
}
