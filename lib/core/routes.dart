import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './/features/auth/admin_login_screen.dart';
import './/features/auth/manager_login_screen.dart';
import './/features/auth/signup_screen.dart';
import './/features/pages/home.dart';
import './/features/pages/artists.dart';
import './/features/pages/dashboard.dart';
import './/features/pages/eventmanager.dart';
import './/features/pages/events.dart';

class AppRouter {
  late final GoRouter router;
  late final String session;
  AppRouter({required this.session}) {
    router = GoRouter(
      initialLocation: session.isEmpty ? '/dashboard' : '/admin-login',
      routes: [
        GoRoute(path: '/', builder: (context, state) => Home()),
        GoRoute(path: '/admin-login', builder: (context, state) => AdminLoginScreen()),
        GoRoute(path: '/manager-login', builder: (context, state) => ManagerLoginScreen()),
        GoRoute(path: '/signup', builder: (context, state) => SignUpScreen()),

        ShellRoute(
          builder: (context, state, child) {
            final location = state.uri.toString();
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/mgmp-logo.png',
                      height: 32,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "MGMP App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                centerTitle: false,
              ),
              body: child,
              bottomNavigationBar: SizedBox(
                height: 65,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.blue.shade800,
                  elevation: 10,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                  selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontSize: 12),
                  currentIndex: _getIndex(location),
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        context.go('/dashboard');
                        break;
                      case 1:
                        context.go('/artists');
                        break;
                      case 2:
                        context.push('/events');
                        break;
                      case 3:
                        context.go('/event-manager');
                        break;
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
                    BottomNavigationBarItem(icon: Icon(Icons.sports_martial_arts_sharp), label: "Artists"),
                    BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
                    BottomNavigationBarItem(icon: Icon(Icons.manage_accounts_outlined), label: "EventManager"),
                  ],
                ),
              ),
            );
          },
          routes: [
            GoRoute(path: '/dashboard', builder: (context, state) => Dashboard()),
            GoRoute(path: '/artists', builder: (context, state) => Artists()),
            GoRoute(path: '/events', builder: (context, state) => Events()),
            GoRoute(path: '/event-manager', builder: (context, state) => EventManager()),
          ],
        ),
      ],
    );
  }

  static int _getIndex(String location) {
    if (location.startsWith('/artists')) return 1;
    if (location.startsWith('/events')) return 2;
    if (location.startsWith('/event-manager')) return 3;
    return 0;
  }
}
