import 'package:fluxus/app/core/utils/drop_down_abstract.dart';

class StartDateDropDrow extends DropDrowAbstract {
  final String? hour;
  final String? minute;
  StartDateDropDrow({
    super.name,
    this.hour,
    this.minute,
  });
}
