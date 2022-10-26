import 'package:fluxus/app/core/models/office_model.dart';

abstract class OfficeRepository {
  Future<List<OfficeModel>> list();
}
