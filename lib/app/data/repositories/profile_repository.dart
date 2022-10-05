import 'package:fluxus/app/core/models/profile_model.dart';

abstract class ProfileRepository {
  // Future<String> create(ProfileModel userProfileModel);
  Future<String> update(ProfileModel userProfileModel);
}
