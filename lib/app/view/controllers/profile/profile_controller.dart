import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/xfile_to_parsefile.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController with LoaderMixin, MessageMixin {
  final ProfileRepository _profileRepository;
  ProfileController({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _profile = Rxn<ProfileModel>();
  ProfileModel? get profile => _profile.value;

  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? selectedDate1) {
    if (selectedDate1 != null) {
      _selectedDate.value =
          DateTime(selectedDate1.year, selectedDate1.month, selectedDate1.day);
    }
  }

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    ProfileModel model = Get.arguments;
    setProfile(model);
    super.onInit();
  }

  setProfile(ProfileModel model) {
    _profile(model);
    onSelectedDate();
  }

  void onSelectedDate() {
    selectedDate = profile?.birthday;
  }

  Future<void> append({
    String? name,
    String? phone,
    String? address,
    String? cep,
    String? pluscode,
    String? cpf,
    bool? isFemale,
    DateTime? birthday,
    String? register,
    String? description,
  }) async {
    try {
      _loading(true);
      var userProfile = _profile.value!.copyWith(
        name: name,
        phone: phone,
        address: address,
        cep: cep,
        pluscode: pluscode,
        cpf: cpf,
        isFemale: isFemale,
        register: register,
        description: description,
        birthday: selectedDate,
      );
      String userProfileId = await _profileRepository.update(userProfile);
      if (_xfile != null) {
        await XFileToParseFile.xFileToParseFile(
          xfile: _xfile!,
          className: ProfileEntity.className,
          objectId: userProfileId,
          objectAttribute: 'photo',
        );
      }
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
