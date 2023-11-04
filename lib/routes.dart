import 'package:desktop_serial_port_app/homepage.dart';
import 'package:desktop_serial_port_app/io_page.dart';
import 'package:desktop_serial_port_app/port_details.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter returnRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(name: "IO", path: "/io", builder: (context, state) => IOPage()),
      GoRoute(name: "Home", path: "/", builder: (context, state) => HomePage()),
      GoRoute(
        name: "Port",
        path: "/port-details/:name",
        builder: (context, state) {
          final String name = state.pathParameters['name']!;
          return PortDetails(portPassedName: name);
        },
      ),
    ],
  );
}
