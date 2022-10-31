import 'dart:developer';

import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class ProfileViewController extends GetxController
    with LoaderMixin, MessageMixin {
  final ProfileRepository _profileRepository;
  ProfileViewController({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;
  // @override
  // void onReady() async {
  //   await getProfile();

  //   super.onReady();
  // }

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _profile = Rxn<ProfileModel>();
  ProfileModel? get profile => _profile.value;
  set profile(ProfileModel? profileModelNew) => _profile(profileModelNew);

  String? clientId;
  List<String>? includeColumns;

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    Map<String, dynamic> args = Get.arguments;
    log('$args', name: 'ClientViewController');
    clientId = args['clientId'];
    includeColumns = args['includeColumns'];
    super.onInit();
  }

  Future<ProfileModel> getProfile() async {
    // _loading(true);
    ProfileModel? profileModelTemp = await _profileRepository
        .readById(clientId!, includeColumns: includeColumns);
    // .readById(clientId!, includeColumns: ['name', 'procedure']);
    profile = profileModelTemp;
    return profileModelTemp!;
    // _loading(false);
  }
}
