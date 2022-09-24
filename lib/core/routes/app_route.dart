import 'package:direct_drivers/presentation/modules/auth/forgot_password/view/forgot_password.dart';
import 'package:direct_drivers/presentation/modules/auth/reset_password/view/reset_password.dart';
import 'package:direct_drivers/presentation/modules/auth/sign_up/view/signup_screen.dart';
import 'package:direct_drivers/presentation/modules/auth/verifcation/controller/verification_controller.dart';
import 'package:direct_drivers/presentation/modules/auth/verifcation/views/driver_verification_screen.dart';
import 'package:direct_drivers/presentation/modules/drivers/account/views/account_screen.dart';
import 'package:direct_drivers/presentation/modules/drivers/dashboard/controller/dashboard_controller.dart';
import 'package:direct_drivers/presentation/modules/drivers/home/controller/home_controller.dart';
import 'package:direct_drivers/presentation/modules/drivers/notification/controller/controller.dart';
import 'package:direct_drivers/presentation/modules/drivers/notification_details/views/read_notification.dart';
import 'package:direct_drivers/presentation/modules/drivers/profile/controller/controller.dart';
import 'package:direct_drivers/presentation/modules/drivers/notification/view/notification_screen.dart';
import 'package:direct_drivers/presentation/modules/drivers/profile/views/profile-screen.dart';
import 'package:direct_drivers/presentation/modules/terms_and_conditions/view/terms_and_condition_screen.dart';
import 'package:get/get.dart';
import '../../presentation/modules/auth/login/view/login_screen.dart';
import '../../presentation/modules/auth/otp/views/otp_screen.dart';
import '../../presentation/modules/drivers/home/views/home_page.dart';
import '../../presentation/modules/onboarding/views/onboarding_screen.dart';
import '../../presentation/modules/onboarding/views/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const onBoarding = '/onBoarding';
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';
  static const signup = '/signup';
  static const otp = '/otp';
  static const customerTypeScreen = '/customerTypeScreen';
  static const home = '/home';
  static const notification = '/notification';
  static const readNotification = '/readNotification';

  static const profilePrompt = '/profilePrompt';
  static const termAndCondition = '/term&Condition';
  static const driverVerification = '/driverVerification';
  static const dashboard = '/dashboard';
  static const resetPassword = '/resetPassword';
  static const profile = '/profile';
  static const account = '/account';
}

// This is simple and will allow you use nested navigation
class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.splash,
      transition: Transition.circularReveal,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.onBoarding,
      transition: Transition.circularReveal,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
        name: Routes.login,
      transition: Transition.circularReveal,
        page: () =>  const LoginScreen(),
    ),
    GetPage(
      name: Routes.signup,
      transition: Transition.circularReveal,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.otp,
      transition: Transition.circularReveal,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      transition: Transition.circularReveal,
        binding: BindingsBuilder(() {
          Get.put(HomeController(),);
          Get.put(DashBoardController(),);
        })
    ),
    GetPage(
      name: Routes.notification,
      transition: Transition.circularReveal,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: Routes.termAndCondition,
      transition: Transition.circularReveal,
      page: () => TermsAndConditions(),
    ),
    GetPage(
      name: Routes.driverVerification,
      transition: Transition.circularReveal,
      page: () => const DriverVerification(),
        binding: BindingsBuilder(() {
          Get.put(VerificationController(),);
        })
    ),
    GetPage(
      name: Routes.forgotPassword,
      transition: Transition.circularReveal,
      page: () => ForgotPassword(),
    ),
    GetPage(
      name: Routes.resetPassword,
      transition: Transition.circularReveal,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
        name: Routes.profile,
        page: () => Profile(),
        transition: Transition.circularReveal,
        binding: BindingsBuilder(() {
          Get.put(ProfileController());
          Get.put(HomeController());
        })),
    GetPage(
        name: Routes.account,
        page: () => Account(),
        transition: Transition.circularReveal,
        binding: BindingsBuilder(() {
          Get.put(ProfileController());
          Get.put(HomeController());
        })),


    GetPage(
      name: Routes.readNotification,
      page: () => ReadNotification(),
      binding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
    ),
    // GetPage(
    //   name: Routes.orderDetails,
    //   page: () => OrderDetails(),
    //   binding: BindingsBuilder(() {
    //     Get.put(CartController());
    //   }),
    // ),
    // GetPage(
    //   name: Routes.orderSummary,
    //   page: () => OrderSummaryScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(CartController());
    //   }),
    // ),
    // GetPage(
    //   name: Routes.trackOrder,
    //   page: () => TrackOrderScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(CartController());
    //   }),
    // ),
    // GetPage(
    //   name: Routes.orderReceipt,
    //   page: () => OrderReceiptScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(CartController());
    //   }),
    // ),
    //
    // GetPage(
    //     name: Routes.menu,
    //     page: () => MenuScreen(),
    //     binding: BindingsBuilder(() {
    //       Get.put(MenuController());
    //     })),
    // GetPage(
    //   name: Routes.menuItemDetails,
    //   page: () => MenuItemDetails(),
    // ),
    // GetPage(
    //   name: Routes.newMenuItem,
    //   page: () => NewMenuItem(),
    // ),
    //
    // GetPage(
    //   name: Routes.addOn,
    //   page: () => NewAddOnScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(AddOnController());
    //   }),
    // ),
    //
    // // Wallet
    // GetPage(
    //   name: Routes.wallet,
    //   page: () => WalletScreen(),
    // ),
    // GetPage(
    //   name: Routes.transactions,
    //   page: () => TransactionsScreen(),
    // ),
    // GetPage(
    //   name: Routes.withdrawal,
    //   page: () => WithdrawalScreen(),
    // ),
    //
    // // Order history
    // GetPage(
    //   name: Routes.history,
    //   page: () => HistoryScreen(),
    // ),
    //
    // // Settings
    // GetPage(
    //   name: Routes.settings,
    //   page: () => SettingsScreen(),
    // ),
    //
    // GetPage(
    //   name: Routes.editProfile,
    //   page: () => EditProfileScreen(),
    // ),
    //
    // GetPage(
    //   name: Routes.changePassword,
    //   page: () => ChangePasswordScreen(),
    // ),
    //
    // GetPage(
    //   name: Routes.withdrawalPin,
    //   page: () => WithdrawalPinScreen(),
    // ),
    // GetPage(
    //   name: Routes.withdrawalAccount,
    //   page: () => WithdrawalAccountScreen(),
    // ),
    //
    // // Resturant
    // GetPage(
    //   name: Routes.resturant,
    //   page: () => ResturantScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(RestaurantController());
    //   }),
    // ),
    //
    // GetPage(
    //   name: Routes.dish,
    //   page: () => DishScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(RestaurantController());
    //   }),
    // ),
    //
    // GetPage(
    //   name: Routes.checkout,
    //   page: () => CheckoutScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(CheckOutController());
    //   }),
    // ),
    //
    // GetPage(
    //   name: Routes.cart,
    //   page: () => CartScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(CartController());
    //   }),
    // ),
    //
    // GetPage(
    //   name: Routes.payment,
    //   page: () => PaymentScreen(),
    //   // binding: BindingsBuilder(() {
    //   //   Get.put(ResturantController());
    //   // }),
    // ),
    //
    // // Location
    // GetPage(
    //   name: Routes.locationPrompt,
    //   page: () => LocationPrompt(),
    //   binding: BindingsBuilder(() {
    //     Get.put(AddressController());
    //   }),
    // ),
    // GetPage(
    //   name: Routes.newAddress,
    //   page: () => NewAddressScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(AddressController());
    //   }),
    // ),
    // GetPage(
    //   name: Routes.savedAddress,
    //   page: () => SavedAddressesScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.put(AddressController());
    //   }),
    // ),
    //
    // // Customer Orders
    // GetPage(
    //   name: Routes.customerOrders,
    //   page: () => OrdersScreen(),
    //   // binding: BindingsBuilder(() {
    //   //   Get.put(ResturantController());
    //   // }),
    // ),
    // GetPage(
    //   name: Routes.customerOrder,
    //   page: () => OrderScreen(),
    //   // binding: BindingsBuilder(() {
    //   //   Get.put(ResturantController());
    //   // }),
    // ),
    //
    // // Filter
    // GetPage(
    //   name: Routes.searchFilter,
    //   page: () => FilterScreen(),
    // ),
    // GetPage(
    //   name: Routes.dashboardFilter,
    //   page: () => DashboardFilter(),
    // ),
    // GetPage(
    //   name: Routes.ordersFilter,
    //   page: () => OrdersFilter(),
    // ),
    //
    // // Notifications
    // GetPage(
    //   name: Routes.notifications,
    //   page: () => NotificationsScreen(),
    // ),
    //
    // // Communication
    // GetPage(
    //   name: Routes.calling,
    //   page: () => CallingScreen(),
    // ),
    //
    // GetPage(
    //   name: Routes.chatBox,
    //   page: () => ChatBoxScreen(),
    // ),
    // GetPage(
    //   name: Routes.chat,
    //   page: () => ChatScreen(),
    // ),
    //
    // // Others
    // GetPage(
    //   name: Routes.ratings,
    //   page: () => RatingsScreen(),
    // ),
    // GetPage(
    //   name: Routes.reviews,
    //   page: () => ReviewsScreen(),
    // ),
    // GetPage(
    //   name: Routes.helpCenter,
    //   page: () => HelpCenterScreen(),
    // ),
  ];
}