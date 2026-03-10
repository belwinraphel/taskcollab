import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

import '../../../projects/presentation/pages/project_dashboard_page.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.map(
            initial: (_) {},
            loading: (_) {},
            authenticated: (_) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const ProjectDashboardPage()));
            },
            unauthenticated: (state) {
              if (state.sessionExpired) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session expired. Please login again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            },
            error: (state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            },
          );
        },
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: RepaintBoundary(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
          ),
        ),
      ),
    );
  }
}
