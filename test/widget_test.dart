import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_test/calculator.dart';
import 'package:flutter_widget_test/calculator.mocks.dart';
import 'package:flutter_widget_test/custom_text.dart';

import 'package:flutter_widget_test/main.dart';
import 'package:flutter_widget_test/operation.dart';
import 'package:flutter_widget_test/two_digit_operation.dart';
import 'package:mockito/mockito.dart';

void main() {
  late Calculator calc;
  //her testten önce çalışır
  setUp(
    () {
      calc = MockCalculator();
    },
  );
  testWidgets('CustomText_RenderFourWidgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(CustomText), findsNWidgets(5));
  });

  testWidgets(
    'ShowsResultWhenGivenTwoNumbers',
    (tester) async {
      //find by key ile test etmekk istediğimiz o widgetı yakalıyoruz
      final finder1 = find.byKey(const Key('Tf1'));
      final finder2 = find.byKey(const Key('Tf2'));

      await tester.pumpWidget(const MyApp());

      await tester.ensureVisible(finder1);
      //test edilen widgeta odaklanıyor
      await tester.tap(finder1);
      await tester.enterText(finder1, '3');
      //o finder görünürmü
      await tester.ensureVisible(finder2);
      await tester.tap(finder2);
      await tester.enterText(finder2, '6');
      //expect çalışana kadar render alıyor pumpdan farkı budur
      await tester.pumpAndSettle();

      expect(find.text('9.0'), findsOneWidget);
    },
  );

  group('Two digit operaiton', () {
    group('Operation.add', () {
      testWidgets('Paints 4.0 when adding 3 and 1', (tester) async {
        final finder1 = find.byKey(const Key('textfield_top_plus'));
        final finder2 = find.byKey(const Key('textfield_bottom_plus'));

        //mockito ile oluştueduğumuz instanceı test ettik
        when(calc.add(3.0, 1.0)).thenReturn(4.0);

        //dart vm de bütün app değilde sadece widgetı ayaga kaldırıyruz
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              calculator: calc,
              operation: Operation.add,
            ),
          ),
        ));

        await tester.ensureVisible(finder1);
        await tester.tap(finder1);
        await tester.enterText(finder1, '3');

        await tester.ensureVisible(finder2);
        await tester.tap(finder2);
        await tester.enterText(finder2, '1');

        await tester.pumpAndSettle();

        expect(find.text('4'), findsOneWidget);
      });
    });

    // group('Operation.divide', () {
    //   testWidgets('Throws exception when divide 3 and 0', (tester) async {
    //     final finder1 = find.byKey(const Key('textfield_top_plus'));
    //     final finder2 = find.byKey(const Key('textfield_bottom_plus'));

    //     //mockito ile oluştueduğumuz instanceı test ettik
    //     when(calc.divide(8.0, 0.0)).thenThrow(Exception('you can not divice by zero'));

    //     //dart vm de bütün app değilde sadece widgetı ayaga kaldırıyruz
    //     await tester.pumpWidget(MaterialApp(
    //       home: Scaffold(
    //         body: TwoDigitOperation(
    //           calculator: calc,
    //           operation: Operation.divide,
    //         ),
    //       ),
    //     ));

    //     await tester.ensureVisible(finder1);
    //     await tester.tap(finder1);
    //     await tester.enterText(finder1, '8.0');

    //     await tester.ensureVisible(finder2);
    //     await tester.tap(finder2);
    //     await tester.enterText(finder2, '0.0');

    //     await tester.pumpAndSettle();

    //     expect(find.text('0'), findsOneWidget);
    //   });
    // });

    group('Operation.PowerTo', () {
      testWidgets('Result should be 25 when input5', (tester) async {
        final finder1 = find.byKey(const Key('textfield_top_plus'));
        final finder2 = find.byKey(const Key('textfield_bottom_plus'));

        //mockito ile oluştueduğumuz instanceı test ettik
        when(calc.powerTo(5, 2)).thenAnswer(
          (realInvocation) => Future.value(25),
        );

        //dart vm de bütün app değilde sadece widgetı ayaga kaldırıyruz
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              calculator: calc,
              operation: Operation.powerTo,
            ),
          ),
        ));

        await tester.ensureVisible(finder1);
        await tester.tap(finder1);
        await tester.enterText(finder1, '5');

        await tester.ensureVisible(finder2);
        await tester.tap(finder2);
        await tester.enterText(finder2, '2');

        await tester.pumpAndSettle();

        expect(find.text('25'), findsOneWidget);
      });
    });
  });
}
