import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homeinsuranceapp/main.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // Verify that our home page includes the introduction text .
    expect(find.text("All your protection under one roof .Take Home Insurance now and secure your future. Don't forget to exlore the exciting discounts available "), findsOneWidget);
    
    // Test that icon button in the drawer is working - TODO 
    /*final drawerOpenButton = find.byTooltip("Open navigation menu");
    await driver.waitFor(drawerOpenButton);*/

    
  });
}

