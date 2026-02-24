import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_collab_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_collab_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_collab_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:task_collab_app/features/auth/presentation/pages/login_page.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState>
    implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('LoginPage renders correctly', (tester) async {
    whenListen(
      mockAuthBloc,
      Stream<AuthState>.fromIterable([
        const AuthState.initial(),
      ]),
      initialState: const AuthState.initial(),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Tapping Login adds AuthLogin event', (tester) async {
    whenListen(
      mockAuthBloc,
      Stream<AuthState>.fromIterable([
        const AuthState.initial(),
      ]),
      initialState: const AuthState.initial(),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField).first, 'ashika@gmail.com');
    await tester.enterText(find.byType(TextField).last, 'ashika@123');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    verify(() => mockAuthBloc.add(
      const AuthEvent.loginRequested(
        'ashika@gmail.com',
        'ashika@123',
      ),
    )).called(1);
  });
}
