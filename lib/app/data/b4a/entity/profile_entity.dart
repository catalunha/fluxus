import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/office_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/expertise_entity.dart';
import 'package:fluxus/app/data/b4a/entity/health_plan_entity.dart';
import 'package:fluxus/app/data/b4a/entity/office_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileEntity {
  static const String className = 'Profile';

  Future<ProfileModel> fromParse(ParseObject parseObject) async {
    //+++ get expertises
    List<ExpertiseModel> expertiseList = [];
    QueryBuilder<ParseObject> queryExpertise =
        QueryBuilder<ParseObject>(ParseObject(ExpertiseEntity.className));
    queryExpertise.whereRelatedTo(
        'expertise', 'Profile', parseObject.objectId!);
    final ParseResponse responseExpertise = await queryExpertise.query();
    if (responseExpertise.success && responseExpertise.results != null) {
      expertiseList = [
        ...responseExpertise.results!
            .map<ExpertiseModel>(
                (e) => ExpertiseEntity().fromParse(e as ParseObject))
            .toList()
      ];
    }
    //--- get expertises

    //+++ get office
    List<OfficeModel> officeList = [];
    QueryBuilder<ParseObject> queryOffice =
        QueryBuilder<ParseObject>(ParseObject(OfficeEntity.className));
    queryOffice.whereRelatedTo('office', 'Profile', parseObject.objectId!);
    final ParseResponse responseOffice = await queryOffice.query();
    if (responseOffice.success && responseOffice.results != null) {
      officeList = [
        ...responseOffice.results!
            .map<OfficeModel>((e) => OfficeEntity().fromParse(e as ParseObject))
            .toList()
      ];
    }
    //--- get office

    //+++ get healthPlanList
    List<HealthPlanModel> healthPlanList = [];

    QueryBuilder<ParseObject> queryHealthPlan =
        QueryBuilder<ParseObject>(ParseObject(HealthPlanEntity.className));
    queryHealthPlan.whereRelatedTo(
        'healthPlan', 'Profile', parseObject.objectId!);
    queryHealthPlan.includeObject(['healthPlanType']);
    final ParseResponse responseHealthPlan = await queryHealthPlan.query();
    if (responseHealthPlan.success && responseHealthPlan.results != null) {
      healthPlanList = [
        ...responseHealthPlan.results!
            .map<HealthPlanModel>(
                (e) => HealthPlanEntity().fromParse(e as ParseObject))
            .toList()
      ];
    }
    //--- get healthPlanList

    //+++ get family
    List<ProfileModel> familyList = [];
    QueryBuilder<ParseObject> queryFamily =
        QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    queryFamily.whereRelatedTo('family', 'Profile', parseObject.objectId!);
    final ParseResponse responseFamily = await queryFamily.query();
    if (responseFamily.success && responseFamily.results != null) {
      for (var e in responseFamily.results!) {
        familyList.add(ProfileEntity().fromParseSimpleData(e as ParseObject));
      }

      // familyList = [
      //   ...responseFamily.results!
      //       .map<ProfileModel>((e) async => await ProfileEntity().fromParse(e as ParseObject))
      //       .toList()
      // ];
    }
    //--- get family

    //+++ get children
    List<ProfileModel> childrenList = [];
    QueryBuilder<ParseObject> queryChildren =
        QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    queryChildren.whereRelatedTo('children', 'Profile', parseObject.objectId!);
    final ParseResponse responseChildren = await queryChildren.query();
    if (responseChildren.success && responseChildren.results != null) {
      for (var e in responseChildren.results!) {
        childrenList.add(ProfileEntity().fromParseSimpleData(e));
      }

      // familyList = [
      //   ...responseFamily.results!
      //       .map<ProfileModel>((e) async => await ProfileEntity().fromParse(e as ParseObject))
      //       .toList()
      // ];
    }
    //--- get children

    ProfileModel profileModel = ProfileModel(
      id: parseObject.objectId!,
      email: parseObject.get('email'),
      name: parseObject.get('name'),
      birthday: parseObject.get('birthday'),
      phone: parseObject.get('phone'),
      address: parseObject.get('address'),
      cep: parseObject.get('cep'),
      pluscode: parseObject.get('pluscode'),
      cpf: parseObject.get('cpf'),
      description: parseObject.get('description'),
      register: parseObject.get('register'),
      photo: parseObject.get('photo')?.get('url'),
      isActive: parseObject.get('isActive') ?? false,
      isDeleted: parseObject.get('isDeleted') ?? false,
      isFemale: parseObject.get('isFemale') ?? false,
      expertise: expertiseList,
      office: officeList,
      healthPlan: healthPlanList,
      family: familyList,
      children: childrenList,
    );
    return profileModel;
  }

  ProfileModel fromParseSimpleData(ParseObject parseObject) {
    ProfileModel profileModel = ProfileModel(
      id: parseObject.objectId!,
      email: parseObject.get('email'),
      name: parseObject.get('name'),
      birthday: parseObject.get('birthday'),
      phone: parseObject.get('phone'),
      address: parseObject.get('address'),
      cep: parseObject.get('cep'),
      pluscode: parseObject.get('pluscode'),
      cpf: parseObject.get('cpf'),
      description: parseObject.get('description'),
      register: parseObject.get('register'),
      photo: parseObject.get('photo')?.get('url'),
      isActive: parseObject.get('isActive') ?? false,
      isDeleted: parseObject.get('isDeleted') ?? false,
      isFemale: parseObject.get('isFemale') ?? false,
    );
    return profileModel;
  }

  Future<ParseObject> toParse(ProfileModel profileModel) async {
    final profileParseObject = ParseObject(ProfileEntity.className);
    if (profileModel.id != null) {
      profileParseObject.objectId = profileModel.id;
    }
    if (profileModel.name != null) {
      profileParseObject.set('name', profileModel.name);
    }
    if (profileModel.description != null) {
      profileParseObject.set('description', profileModel.description);
    }
    if (profileModel.phone != null) {
      profileParseObject.set('phone', profileModel.phone);
    }
    if (profileModel.email != null) {
      profileParseObject.set('email', profileModel.email);
    }
    if (profileModel.address != null) {
      profileParseObject.set('address', profileModel.address);
    }
    if (profileModel.cep != null) {
      profileParseObject.set('cep', profileModel.cep);
    }
    if (profileModel.pluscode != null) {
      profileParseObject.set('pluscode', profileModel.pluscode);
    }
    if (profileModel.cpf != null) {
      profileParseObject.set('cpf', profileModel.cpf);
    }
    if (profileModel.register != null) {
      profileParseObject.set('register', profileModel.register);
    }
    if (profileModel.isActive != null) {
      profileParseObject.set('isActive', profileModel.isActive);
    }
    if (profileModel.isDeleted != null) {
      profileParseObject.set('isDeleted', profileModel.isDeleted);
    }
    print('=========> ${profileModel.isFemale}');
    if (profileModel.isFemale != null) {
      profileParseObject.set('isFemale', profileModel.isFemale);
    }
    if (profileModel.birthday != null) {
      profileParseObject.set('birthday', profileModel.birthday);
    }
    return profileParseObject;
  }

  ParseObject? toParseUpdateRelationHealthPlan({
    required String objectId,
    required bool add,
    required List<String> modelIdList,
  }) {
    print('objectId:$objectId, modelIdList:${modelIdList.join("|")},add:$add');
    final parseObject = ParseObject(ProfileEntity.className);
    parseObject.objectId = objectId;
    if (add) {
      if (modelIdList.isEmpty) {
        parseObject.unset('healthPlan');
      } else {
        parseObject.addRelation(
          'healthPlan',
          modelIdList
              .map(
                (element) =>
                    ParseObject(HealthPlanEntity.className)..objectId = element,
              )
              .toList(),
        );
      }
    } else {
      if (modelIdList.isEmpty) {
        parseObject.unset('healthPlan');
      } else {
        parseObject.removeRelation(
            'healthPlan',
            modelIdList
                .map((element) =>
                    ParseObject(HealthPlanEntity.className)..objectId = element)
                .toList());
      }
    }
    return parseObject;
  }

  ParseObject? toParseUpdateRelationChildren({
    required String objectId,
    required bool add,
    required List<String> modelIdList,
  }) {
    final parseObject = ParseObject(ProfileEntity.className);
    parseObject.objectId = objectId;
    if (add) {
      if (modelIdList.isEmpty) {
        parseObject.unset('children');
      } else {
        parseObject.addRelation(
          'children',
          modelIdList
              .map(
                (element) =>
                    ParseObject(ProfileEntity.className)..objectId = element,
              )
              .toList(),
        );
      }
    } else {
      if (modelIdList.isEmpty) {
        parseObject.unset('children');
      } else {
        parseObject.removeRelation(
            'children',
            modelIdList
                .map((element) =>
                    ParseObject(ProfileEntity.className)..objectId = element)
                .toList());
      }
    }
    return parseObject;
  }

  ParseObject? toParseUpdateRelationFamily({
    required String objectId,
    required bool add,
    required List<String> modelIdList,
  }) {
    final parseObject = ParseObject(ProfileEntity.className);
    parseObject.objectId = objectId;
    if (add) {
      if (modelIdList.isEmpty) {
        parseObject.unset('family');
      } else {
        parseObject.addRelation(
          'family',
          modelIdList
              .map(
                (element) =>
                    ParseObject(ProfileEntity.className)..objectId = element,
              )
              .toList(),
        );
      }
    } else {
      if (modelIdList.isEmpty) {
        parseObject.unset('family');
      } else {
        parseObject.removeRelation(
            'family',
            modelIdList
                .map((element) =>
                    ParseObject(ProfileEntity.className)..objectId = element)
                .toList());
      }
    }
    return parseObject;
  }

  ParseObject? toParseUpdateRelationOffice({
    required String objectId,
    required bool add,
    required List<String> modelIdList,
  }) {
    final parseObject = ParseObject(ProfileEntity.className);
    parseObject.objectId = objectId;
    if (add) {
      if (modelIdList.isEmpty) {
        parseObject.unset('office');
      } else {
        parseObject.addRelation(
          'office',
          modelIdList
              .map(
                (element) =>
                    ParseObject(OfficeEntity.className)..objectId = element,
              )
              .toList(),
        );
      }
    } else {
      if (modelIdList.isEmpty) {
        parseObject.unset('office');
      } else {
        parseObject.removeRelation(
            'office',
            modelIdList
                .map((element) =>
                    ParseObject(OfficeEntity.className)..objectId = element)
                .toList());
      }
    }
    return parseObject;
  }
}
