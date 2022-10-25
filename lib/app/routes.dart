import 'package:fluxus/app/view/controllers/client/addedit/client_addedit_dependencies.dart';
import 'package:fluxus/app/view/controllers/client/search/client_search_dependencies.dart';
import 'package:fluxus/app/view/controllers/client/view/client_view_dependencies.dart';
import 'package:fluxus/app/view/controllers/evaluation/addedit/evaluation_addedit_dependencies.dart';
import 'package:fluxus/app/view/controllers/evaluation/search/evaluation_search_dependencies.dart';
import 'package:fluxus/app/view/controllers/event/addedit/event_addedit_dependencies.dart';
import 'package:fluxus/app/view/controllers/event/search/event_search_dependencies.dart';
import 'package:fluxus/app/view/controllers/health_plan/search/health_plan_search_dependencies.dart';
import 'package:fluxus/app/view/controllers/team/search/team_search_dependencies.dart';
import 'package:fluxus/app/view/controllers/user/profile/user_profile_dependencies.dart';
import 'package:fluxus/app/view/controllers/user/register/email/user_register_email_dependencies.dart';
import 'package:fluxus/app/view/controllers/user/login/login_dependencies.dart';
import 'package:fluxus/app/view/controllers/splash/splash_dependencies.dart';
import 'package:fluxus/app/view/controllers/home/home_dependencies.dart';
import 'package:fluxus/app/view/pages/client/addedit/client_addedit_page.dart';
import 'package:fluxus/app/view/pages/client/addedit/client_health_plan_addedit_page.dart';
import 'package:fluxus/app/view/pages/client/search/client_search_list_page.dart';
import 'package:fluxus/app/view/pages/client/search/client_search_page.dart';
import 'package:fluxus/app/view/pages/client/view/client_view_page.dart';
import 'package:fluxus/app/view/pages/evaluation/addedit/evaluation_addedit_page.dart';
import 'package:fluxus/app/view/pages/evaluation/search/evaluation_search_list_page.dart';
import 'package:fluxus/app/view/pages/evaluation/search/evaluation_search_page.dart';
import 'package:fluxus/app/view/pages/event/addedit/event_addedit_page.dart';
import 'package:fluxus/app/view/pages/event/search/event_search_list_page.dart';
import 'package:fluxus/app/view/pages/event/search/event_search_page.dart';
import 'package:fluxus/app/view/pages/health_plan/search/health_plan_search_list_page.dart';
import 'package:fluxus/app/view/pages/health_plan/search/health_plan_search_page.dart';
import 'package:fluxus/app/view/pages/team/team_search_list_page.dart';
import 'package:fluxus/app/view/pages/team/team_search_page.dart';
import 'package:fluxus/app/view/pages/user/profile/health_plan_addedit_page.dart';
import 'package:fluxus/app/view/pages/user/profile/profile_page.dart';
import 'package:fluxus/app/view/pages/user/login/auth_login_page.dart';
import 'package:fluxus/app/view/pages/user/register/email/user_register_email.page.dart';
import 'package:fluxus/app/view/pages/splash/splash_page.dart';
import 'package:fluxus/app/view/pages/home/home_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';

  static const userLogin = '/user/login';

  static const userRegisterEmail = '/user/register/email';

  static const home = '/home';

  static const profile = '/user/profile';
  static const profileHealthPlan = '/user/profile/healthPlan';

  static const clientProfileSearch = '/client/profile/search';
  static const clientProfileList = '/client/profile/list';
  static const clientProfileAddEdit = '/client/profile/addedit';
  static const clientProfileHealthPlan = '/client/profile/healthPlan';
  static const clientProfileView = '/client/profile/view';

  static const healthPlanSearch = '/healthPlan/search';
  static const healthPlanList = '/healthPlan/list';

  static const teamProfileSearch = '/team/search';
  static const teamProfileList = '/team/list';

  static const eventAddEdit = '/event/addedit';
  static const eventSearch = '/event/search';
  static const eventList = '/event/list';

  static const evaluationAddEdit = '/evaluation/addedit';
  static const evaluationSearch = '/evaluation/search';
  static const evaluationList = '/evaluation/list';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: SplashDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.userLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.userRegisterEmail,
      binding: UserRegisterEmailDependencies(),
      page: () => AuthRegisterEmailPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      page: () => HomePage(),
      children: const [],
    ),
    GetPage(
      name: Routes.profile,
      binding: UserProfileDependencies(),
      page: () => ProfilePage(),
    ),
    GetPage(
      name: Routes.profileHealthPlan,
      page: () => HealthPlanAddEditPage(),
    ),
    GetPage(
      name: Routes.clientProfileSearch,
      binding: ClientSearchDependencies(),
      page: () => ClientSearchPage(),
    ),
    GetPage(
      name: Routes.clientProfileList,
      page: () => ClientSearchListPage(),
    ),
    GetPage(
      name: Routes.clientProfileAddEdit,
      binding: ClientAddEditDependencies(),
      page: () => const ClientAddEditPage(),
    ),
    GetPage(
      name: Routes.clientProfileHealthPlan,
      page: () => ClientHealthPlanAddEditPage(),
    ),
    GetPage(
      name: Routes.healthPlanSearch,
      binding: HealthPlanSearchDependencies(),
      page: () => HealthPlanSearchPage(),
    ),
    GetPage(
      name: Routes.healthPlanList,
      page: () => HealthPlanSearchListPage(),
    ),
    GetPage(
      name: Routes.clientProfileView,
      binding: ClientViewDependencies(),
      page: () => ClientViewPage(),
    ),
    GetPage(
      name: Routes.teamProfileSearch,
      binding: TeamSearchDependencies(),
      page: () => TeamSearchPage(),
    ),
    GetPage(
      name: Routes.teamProfileList,
      page: () => TeamSearchListPage(),
    ),
    GetPage(
      name: Routes.eventAddEdit,
      binding: EventAddEditDependencies(),
      page: () => EventAddEditPage(),
    ),
    GetPage(
      name: Routes.eventSearch,
      binding: EventSearchDependencies(),
      page: () => EventSearchPage(),
    ),
    GetPage(
      name: Routes.eventList,
      page: () => EventSearchListPage(),
    ),
    GetPage(
      name: Routes.evaluationAddEdit,
      binding: EvaluationAddEditDependencies(),
      page: () => EvaluationAddEditPage(),
    ),
    GetPage(
      name: Routes.evaluationSearch,
      binding: EvaluationSearchDependencies(),
      page: () => EvaluationSearchPage(),
    ),
    GetPage(
      name: Routes.evaluationList,
      page: () => EvaluationSearchListPage(),
    ),
  ];
}
