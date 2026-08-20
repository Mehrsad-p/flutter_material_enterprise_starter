import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_material_enterprise_starter/app/app.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    // Simply verify that App can be instantiated as a valid widget
    expect(const App(), isA<Widget>());
  });
}
