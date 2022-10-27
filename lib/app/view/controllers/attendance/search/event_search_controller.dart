// import 'package:fluxus/app/core/models/event_model.dart';
// import 'package:fluxus/app/data/b4a/entity/event_entity.dart';
// import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
// import 'package:fluxus/app/data/repositories/event_repository.dart';
// import 'package:fluxus/app/data/utils/pagination.dart';
// import 'package:fluxus/app/routes.dart';
// import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
// import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
// import 'package:get/get.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// class EventSearchController extends GetxController
//     with LoaderMixin, MessageMixin {
//   final EventRepository _eventRepository;
//   EventSearchController({
//     required EventRepository eventRepository,
//   }) : _eventRepository = eventRepository;

//   final _loading = false.obs;
//   final _message = Rxn<MessageModel>();

//   List<EventModel> eventList = <EventModel>[].obs;
//   final _pagination = Pagination().obs;
//   final _lastPage = false.obs;
//   get lastPage => _lastPage.value;

//   // final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
//   // DateTime? get selectedDate => _selectedDate.value;
//   // set selectedDate(DateTime? selectedDate1) {
//   //   _selectedDate.value = selectedDate1;
//   // }

//   QueryBuilder<ParseObject> query =
//       QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
//   @override
//   void onInit() {
//     eventList.clear();
//     _changePagination(1, 12);
//     ever(_pagination, (_) async => await listAll());
//     loaderListener(_loading);
//     messageListener(_message);
//     super.onInit();
//   }

//   void _changePagination(int page, int limit) {
//     _pagination.update((val) {
//       val!.page = page;
//       val.limit = limit;
//     });
//   }

//   void nextPage() {
//     _changePagination(_pagination.value.page + 1, _pagination.value.limit);
//   }

//   Future<void> search({
//     required bool nameContainsBool,
//     // required String nameContainsString,
//     // required bool cpfEqualToBool,
//     // required String cpfEqualToString,
//     // required bool phoneEqualToBool,
//     // required String phoneEqualToString,
//     // required bool birthdayBool,
//   }) async {
//     _loading(true);
//     query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));

//     eventList.clear();
//     if (lastPage) {
//       _lastPage(false);
//       _pagination.update((val) {
//         val!.page = 1;
//         val.limit = 12;
//       });
//       // _changePagination(_pagination.value.page, _pagination.value.limit);
//     } else {
//       await listAll();
//     }
//     _loading(false);
//     Get.toNamed(Routes.eventList);
//   }

//   Future<void> listAll() async {
//     if (!lastPage) {
//       _loading(true);
//       List<EventModel> temp =
//           await _eventRepository.list(query, _pagination.value);
//       if (temp.isEmpty) {
//         _lastPage.value = true;
//       }
//       eventList.addAll(temp);
//       _loading(false);
//     }
//   }
// }
