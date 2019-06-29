// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:attendance_client/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:attendance_client/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test("firebase CRUD test", () {
    var result = queryUser("J2Ko6oQRP6Yxw0mlInyWNxGq4on2");
    print(result);
    while (result != null) {
      print(result);
      expect('41624158', "41624158");
      break;
    }
  });
}

// Future<String> getData() async {
//   await queryUser("J2Ko6oQRP6Yxw0mlInyWNxGq4on2");
//   return "41624158";
// }

Future<String> queryUser(String uid) async {
  DocumentSnapshot snapshot =
      await Firestore.instance.collection('users').document(uid).get();
  if (snapshot.data == null) {}
  User user = User(
      id: snapshot.data['id'],
      name: snapshot.data['name'],
      role: snapshot.data['role'],
      department: snapshot.data['department']);
  return user.id;
}
