import 'package:fluxus/app/core/models/profile_model.dart';

abstract class ProfileRepository {
  Future<String> update(ProfileModel userProfileModel);
  Future<ProfileModel?> readById(String id);
  Future<void> updateRelationHealthPlan(
      String objectId, List<String> modelIdList, bool add);
}
