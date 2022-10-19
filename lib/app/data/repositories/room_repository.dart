import 'package:fluxus/app/core/models/room_model.dart';

abstract class RoomRepository {
  Future<List<RoomModel>> list();
}
