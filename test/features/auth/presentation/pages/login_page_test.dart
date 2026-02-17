import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_collab_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_collab_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_collab_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:task_collab_app/features/auth/presentation/pages/login_page.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (_) => mockAuthBloc,
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('LoginPage renders correctly', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Login'), findsOneWidget); // AppBar title
    expect(find.byType(TextField), findsNWidgets(2)); // Email and Password
    expect(find.text('Sign In'), findsOneWidget); // Button text
  });

  testWidgets('Tapping Sign In adds AuthLogin event', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');
    await tester.tap(find.text('Sign In'));

    verify(() => mockAuthBloc.add(
            const AuthEvent.loginRequested('test@example.com', 'password123')))
        .called(1);
  });
}
