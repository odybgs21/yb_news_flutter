import 'package:get/get.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/news_list_page.dart';
import '../../presentation/pages/news_detail_page.dart';
import '../../presentation/pages/signup_page.dart';
import '../../presentation/pages/forgot_password_page.dart';
import '../../presentation/pages/otp_verification_page.dart';
import '../../presentation/pages/reset_password_page.dart';
import '../../app/bindings/news_binding.dart';
import '../../app/bindings/login_binding.dart';
import '../../app/bindings/signup_binding.dart';
import '../../app/bindings/forgot_password_binding.dart';
import '../../app/bindings/otp_verification_binding.dart';
import '../../app/bindings/reset_password_binding.dart';
import '../../app/bindings/home_binding.dart';
import '../../presentation/pages/comments_page.dart';
import '../../app/bindings/comments_binding.dart';
import '../../presentation/pages/trending_page.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.login;
  static const initialHome = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.newsList,
      page: () => const NewsListPage(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: Routes.newsDetail,
      page: () => const NewsDetailPage(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.otpVerification,
      page: () => const OtpVerificationPage(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: Routes.comments,
      page: () => const CommentsPage(),
      binding: CommentsBinding(),
    ),
    GetPage(
      name: Routes.trending,
      page: () => const TrendingPage(),
      binding: NewsBinding(), // Reuse NewsBinding as it has the controller
    ),
  ];
}
