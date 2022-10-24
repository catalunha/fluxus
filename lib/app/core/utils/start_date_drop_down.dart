import 'package:fluxus/app/core/utils/drop_down_abstract.dart';

class StartDateDropDrow extends DropDrowAbstract {
  final int? hour;
  final int? minute;
  StartDateDropDrow({
    super.name,
    this.hour,
    this.minute,
  });
}
