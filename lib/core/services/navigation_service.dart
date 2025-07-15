import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/user_type_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/booking/screens/booking_screen.dart';
import '../../features/booking/screens/booking_details_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/driver/screens/driver_home_screen.dart';
import '../../features/driver/screens/driver_profile_screen.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    routes: [
      // Auth Routes
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/user-type',
        name: 'user-type',
        builder: (context, state) => const UserTypeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          final userType = state.uri.queryParameters['type'] ?? 'customer';
          return LoginScreen(userType: userType);
        },
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          final userType = state.uri.queryParameters['type'] ?? 'customer';
          return RegisterScreen(userType: userType);
        },
      ),
      
      // Customer Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/booking',
        name: 'booking',
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: '/booking-details/:id',
        name: 'booking-details',
        builder: (context, state) {
          final bookingId = state.pathParameters['id']!;
          return BookingDetailsScreen(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      
      // Driver Routes
      GoRoute(
        path: '/driver-home',
        name: 'driver-home',
        builder: (context, state) => const DriverHomeScreen(),
      ),
      GoRoute(
        path: '/driver-profile',
        name: 'driver-profile',
        builder: (context, state) => const DriverProfileScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'الصفحة غير موجودة',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'المسار المطلوب غير متاح',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    ),
  );
  
  // Navigation Helper Methods
  static void goTo(String route) {
    router.go(route);
  }
  
  static void pushTo(String route) {
    router.push(route);
  }
  
  static void pop() {
    router.pop();
  }
  
  static void pushReplacement(String route) {
    router.pushReplacement(route);
  }
  
  static void goToHome() {
    router.go('/home');
  }
  
  static void goToLogin({String userType = 'customer'}) {
    router.go('/login?type=$userType');
  }
  
  static void goToRegister({String userType = 'customer'}) {
    router.go('/register?type=$userType');
  }
  
  static void goToDriverHome() {
    router.go('/driver-home');
  }
  
  static void goToBooking() {
    router.go('/booking');
  }
  
  static void goToBookingDetails(String bookingId) {
    router.go('/booking-details/$bookingId');
  }
  
  static void goToProfile() {
    router.go('/profile');
  }
}

