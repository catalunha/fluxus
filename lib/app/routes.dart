import 'package:fluxus/app/view/controllers/client/client_profile_dependencies.dart';
import 'package:fluxus/app/view/controllers/user/profile/user_profile_dependencies.dart';
import 'package:fluxus/app/view/controllers/user/register/email/user_register_email_dependencies.dart';
import 'package:fluxus/app/view/controllers/user/login/login_dependencies.dart';
import 'package:fluxus/app/view/controllers/splash/splash_dependencies.dart';
import 'package:fluxus/app/view/controllers/home/home_dependencies.dart';
import 'package:fluxus/app/view/pages/client/client_profile_list_page.dart';
import 'package:fluxus/app/view/pages/client/client_profile_search_page.dart';
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

  static const profile = '/user/profile';
  static const profileHealthPlan = '/user/profile/healthPlan';

  static const clientProfileSearch = '/client/profile/search';
  static const clientProfileList = '/client/profile/list';

  static const home = '/home';

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
      binding: ClientProfileDependencies(),
      page: () => ClientProfileSearchPage(),
    ),
    GetPage(
      name: Routes.clientProfileList,
      page: () => ClientProfileListPage(),
    ),
  ];
}
