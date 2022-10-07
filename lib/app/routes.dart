import 'package:fluxus/app/view/controllers/user/register/email/user_register_email_dependencies.dart';
import 'package:fluxus/app/view/controllers/user/login/login_dependencies.dart';
import 'package:fluxus/app/view/controllers/splash/splash_dependencies.dart';
import 'package:fluxus/app/view/controllers/home/home_dependencies.dart';
import 'package:fluxus/app/view/controllers/profile/profile_dependencies.dart';
import 'package:fluxus/app/view/pages/user/login/auth_login_page.dart';
import 'package:fluxus/app/view/pages/user/register/email/user_register_email.page.dart';
import 'package:fluxus/app/view/pages/splash/splash_page.dart';
import 'package:fluxus/app/view/pages/home/home_page.dart';
import 'package:fluxus/app/view/pages/profile/profile_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';

  static const userLogin = '/user/login';

  static const userRegisterEmail = '/user/register/email';

  static const profile = '/user/profile';

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
      name: Routes.profile,
      binding: ProfileDependencies(),
      page: () => ProfilePage(),
    ),
    GetPage(
        name: Routes.home,
        binding: HomeDependencies(),
        page: () => HomePage(),
        children: const []),
  ];
}
