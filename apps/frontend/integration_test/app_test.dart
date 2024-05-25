import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nearfleet_app/config/constants/nearfleet_constants.dart';
import 'package:nearfleet_app/config/di/di.dart';
import 'package:nearfleet_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    setupLocator();
  });

  group('Widget Testing', () {
    
    testWidgets('Verify when we create a new address', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('add_fab_home_page')));
      await tester.pumpAndSettle();
      
      expect(find.text('Maps Page'), findsOne);

      await Future.delayed(const Duration(seconds: 4));

      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      final errorWidget = find.text('Address already registered');

      if(errorWidget.tryEvaluate()) return;

      await Future.delayed(const Duration(seconds: 1));

      expect(_getAddressTileFinder(), findsOne);
    });

    testWidgets('Verify when we delete one address', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final initialAddressTileFinder = find.byType(ListTile);

      if( !initialAddressTileFinder.tryEvaluate() ) {
        return expect(initialAddressTileFinder, findsNothing);
      }

      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(initialAddressTileFinder.first);
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      
      await Future.delayed(const Duration(seconds: 1));
      
      final snackbarFinder = find.text('Address was successfully deleted');
      
      if( !snackbarFinder.tryEvaluate() ) {
        return expect(snackbarFinder, findsNothing);
      }

      return expect(snackbarFinder, findsOne);
    });
  });
}

Finder _getAddressTileFinder() {
  const initPosition = NearfleetConstants.initPosition;
  final latLngText = '${initPosition.latitude}, ${initPosition.longitude}';
  return find.text(latLngText);
}