import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/databases/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with LoaderMixin, MessageMixin {
  final ProfileRepository _profileRepository;
  ProfileController({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _userProfile = Rxn<ProfileModel>();
  ProfileModel? get userProfile => _userProfile.value;

  // XFile? pickedXFile;
  // setPickedXFile(XFile value) {
  //   pickedXFile = value;
  // }

  // CroppedFile? croppedFile;
  // setCroppedFile(CroppedFile value) {
  //   croppedFile = value;
  // }

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    ProfileModel? model = Get.arguments;
    // //print('Get.arguments = ${Get.arguments}');
    _userProfile(model);
    super.onInit();
  }

  Future<void> append({
    String? name,
    // String? description,
    String? phone,
    // String? unit,
  }) async {
    try {
      _loading(true);

      // if (_userProfile.value == null) {
      //   //print('profile create');
      //   var userProfile = ProfileModel(
      //     id: null,
      //     fullName: fullName,
      //     nameTag: nameTag,
      //     description: description,
      //     isWoman: isWoman,
      //     discord: discord,
      //     telegram: telegram,
      //   );
      //    String userawait _userProfileUseCase.create(userProfile);
      //   if (_xfile != null) {
      //     await XFileToParseFile.xFileToParseFile(
      //       xfile: _xfile!,
      //       className: 'Profile',
      //       attributeClass: 'photo',
      //     );
      //   }
      //   //print(userProfile);

      // } else {
      // final SplashController splashController = Get.find();
      // _userProfile(splashController.userModel!.profile);
      var userProfile = _userProfile.value!.copyWith(
        name: name,
        // description: description,
        phone: phone,
      );
      String userProfileId = await _profileRepository.update(userProfile);
      // if (croppedFile != null) {
      //   await XFileToParseFile.xFileToParseFile(
      //     nameOfFile: pickedXFile!.name,
      //     pathOfFile: croppedFile!.path,
      //     fileInListOfBytes: await croppedFile!.readAsBytes(),
      //     className: UserProfileEntity.className,
      //     objectId: userProfileId,
      //     objectAttribute: 'photo',
      //   );
      // } else if (pickedXFile != null) {
      //   await XFileToParseFile.xFileToParseFile(
      //     nameOfFile: pickedXFile!.name,
      //     pathOfFile: pickedXFile!.path,
      //     fileInListOfBytes: await pickedXFile!.readAsBytes(),
      //     className: UserProfileEntity.className,
      //     objectId: userProfileId,
      //     objectAttribute: 'photo',
      //   );
      // }
      // if (_xfile != null) {
      //   await XFileToParseFile.xFileToParseFile(
      //     xfile: _xfile!,
      //     className: UserProfileEntity.className,
      //     objectId: userProfileId,
      //     objectAttribute: 'photo',
      //   );
      // }
      // }
      final SplashController splashController = Get.find();
      await splashController.updateUserProfile();
    } on ProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ProfileController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
