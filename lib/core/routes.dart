import 'package:flutter/material.dart';
import 'package:flutterxlayer01/features/pages/edit_event.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/admin_login_screen.dart';
import '../features/auth/manager_login_screen.dart';
import '../features/auth/signup_screen.dart';
import '../features/auth/auth_services.dart';
import '../features/pages/home.dart';
import '../features/pages/dashboard.dart';
import '../features/pages/events.dart';
import '../features/pages/artists.dart';
import '../features/pages/eventmanager.dart';
import '../appcolors/app_colors.dart';
import '../features/pages/add_events.dart';
import '../model/event_model.dart';

class AppRouter {
  late final GoRouter router;
  late final String sessionToken;
  AuthServices authServices = AuthServices();

  AppRouter({required this.sessionToken}) {
    router = GoRouter(
      initialLocation: sessionToken.isEmpty ? '/' : '/dashboard',
      routes: [
        GoRoute(path: '/', builder: (context, state) => Home()),
        GoRoute(path: '/admin-login', builder: (context, state) => AdminLoginScreen()),
        GoRoute(path: '/manager-login', builder: (context, state) => ManagerLoginScreen(),),
        GoRoute(path: '/signup', builder: (context, state) => SignUpScreen()),

        ShellRoute(
          builder: (context, state, child) {
            final location = state.uri.toString();
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(65),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF7B61FF), Color(0xFF927EFF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/mgmp-logo.png',
                                  height: 50,
                                ),
                                const SizedBox(width: 10),
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
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  ShowLogoutConfirmationDialog(context);
                                },
                                child: Icon(
                                  Icons.logout,
                                  color: AppColors.iconColor,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              body: child,
              bottomNavigationBar: SizedBox(
                height: 75,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(6, 2, 10, 2),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF7B61FF), Color(0xFF927EFF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      type: BottomNavigationBarType.fixed,
                      elevation: 0,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.black54,
                      selectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      unselectedLabelStyle: const TextStyle(fontSize: 10),
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
                            context.go('/events');
                            break;
                          case 3:
                            context.go('/event-manager');
                            break;
                        }
                      },
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: "Dashboard",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.sports_martial_arts_sharp),
                          label: "Artists",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.event),
                          label: "Events",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.manage_accounts_outlined),
                          label: "Event Manager",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => Dashboard(),
            ),
            GoRoute(
              path: '/artists',
              builder: (context, state) => ArtistsPage(),
            ),
            GoRoute(path: '/events', builder: (context, state) => EventPage()),
            GoRoute(
              path: '/event-manager',
              builder: (context, state) => EventManagersPage(),
            ),
            GoRoute(
              path: '/edit-event',
              builder: (context, state) {
                final EventModel? eventModel = state.extra as EventModel?;
                if (eventModel == null) {
                  return Scaffold(
                    body: Center(child: Text("Error: No event data provided!")),
                  );
                }
                return EditEvent(currentEventData: eventModel);
              },
            ),
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

  void ShowLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Confirm Logout",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4E3B99),
            ),
          ),
          content: Text(
            "Are you sure you want to log out?",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            // Yes Button
            TextButton(
              onPressed: () {
                debugPrint("logout confirmed");
                authServices.logout(context, sessionToken);
                Navigator.of(context).pop();
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Color(0xFF4E3B99),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
