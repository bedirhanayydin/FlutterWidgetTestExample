import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_test/calculator.dart';
import 'package:flutter_widget_test/main.dart';

import 'package:flutter_widget_test/operation.dart';
import 'package:flutter_widget_test/pi.dart';
import 'package:flutter_widget_test/two_digit_operation.dart';
import 'package:mocktail/mocktail.dart';

class MockCalculator extends Mock implements Calculator {}

void main() {
  late MockCalculator calc;
  late Finder finderTextfieldTop;
  late Finder finderTextfieldBottom;
  late Finder finderButton;
  late bool isCalculated;
  //her testten önce çalışır
  setUp(
    () {
      calc = MockCalculator();
      finderTextfieldTop = find.byKey(const Key('textfield_top_plus'));
      finderTextfieldBottom = find.byKey(const Key('textfield_bottom_plus'));
      finderButton = find.byKey(const Key('calc_button'));
      isCalculated = false;
    },
  );
  // testWidgets('CustomText_RenderFourWidgets', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   expect(find.byType(CustomText), findsNWidgets(5));
  // });

  // testWidgets(
  //   'ShowsResultWhenGivenTwoNumbers',
  //   (tester) async {
  //     //find by key ile test etmekk istediğimiz o widgetı yakalıyoruz
  //     final finder1 = find.byKey(const Key('Tf1'));
  //     final finder2 = find.byKey(const Key('Tf2'));

  //     await tester.pumpWidget(const MyApp());

  //     await tester.ensureVisible(finder1);
  //     //test edilen widgeta odaklanıyor
  //     await tester.tap(finder1);
  //     await tester.enterText(finder1, '3');
  //     //o finder görünürmü
  //     await tester.ensureVisible(finder2);
  //     await tester.tap(finder2);
  //     await tester.enterText(finder2, '6');
  //     //expect çalışana kadar render alıyor pumpdan farkı budur
  //     await tester.pumpAndSettle();

  //     expect(find.text('9'), findsOneWidget);
  //   },
  // );

  group('Two digit operaiton', () {
    // group('Operation.add', () {
    //   testWidgets('Paints 4.0 when adding 3 and 1', (tester) async {
    //     //mockito ile oluştueduğumuz instanceı test ettik
    //     when(() => calc.add(3, 1)).thenReturn(4);

    //     //dart vm de bütün app değilde sadece widgetı ayaga kaldırıyruz
    //     await tester.pumpWidget(MaterialApp(
    //       home: Scaffold(
    //         body: TwoDigitOperation(
    //           calculator: calc,
    //           operation: Operation.add,
    //           onCalculated: () => isCalculated = true,
    //         ),
    //       ),
    //     ));

    //     await tester.ensureVisible(finderTextfieldTop);
    //     await tester.tap(finderTextfieldTop);
    //     await tester.enterText(finderTextfieldTop, '3');

    //     await tester.ensureVisible(finderTextfieldBottom);
    //     await tester.tap(finderTextfieldBottom);
    //     await tester.enterText(finderTextfieldBottom, '1');

    //     await tester.pumpAndSettle();

    //     expect(find.text('result=4'), findsOneWidget);
    //   });
    // });

    group('Operation.divide', () {
      testWidgets('result should be 0 when divide 10 to 0', (tester) async {
        when(() => calc.divide(10, 0)).thenThrow(Exception('i am big errorrr!!!'));
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              operation: Operation.divide,
              calculator: calc,
              onCalculated: () => isCalculated = true,
            ),
          ),
        ));

        await tester.ensureVisible(finderTextfieldTop);

        await tester.tap(finderTextfieldTop);
        await tester.enterText(finderTextfieldTop, '10');
        await tester.ensureVisible(finderTextfieldBottom);
        await tester.tap(finderTextfieldBottom);

        await tester.enterText(finderTextfieldBottom, '0');
        await tester.ensureVisible(finderButton);
        await tester.tap(finderButton);
        await tester.pumpAndSettle();

        // verify stubbed calc.divide called for once
        //divide metodu 1 kere çağrılmışmı?
        verify(() => calc.divide(10, 0)).called(1);

        // isCalculated should be false because of throw exception from mock
        expect(isCalculated, false);
      });
    });

    group('Operation.PowerTo', () {
      testWidgets('Result should be 9 when input3', (tester) async {
        //mockito ile oluştueduğumuz instanceı test ettik
        when(() => calc.powerTo(3, 2)).thenAnswer(
          (realInvocation) => Future.value(9),
        );

        //dart vm de bütün app değilde sadece widgetı ayaga kaldırıyruz
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: TwoDigitOperation(
              calculator: calc,
              operation: Operation.powerTo,
              onCalculated: () => isCalculated = true,
            ),
          ),
        ));

        await tester.ensureVisible(finderTextfieldTop);
        await tester.tap(finderTextfieldTop);
        await tester.enterText(finderTextfieldTop, '3');

        await tester.ensureVisible(finderTextfieldBottom);
        await tester.tap(finderTextfieldBottom);
        await tester.enterText(finderTextfieldBottom, '2');
        await tester.tap(finderButton);

        await tester.pumpAndSettle();
        expect(find.text('result=9'), findsOneWidget);
      });
    });
    group('Pi', () {
      testWidgets('renders the result provided by the calculator', (tester) async {
        when(() => calc.pi()).thenAnswer(
          (invocation) => Stream.periodic(
            const Duration(milliseconds: 4),
            ((eventIndex) {
              if (eventIndex == 0) return 3.1;
              if (eventIndex == 1) return 3.14;
              if (eventIndex == 2) return 3.141;
              return null;
            }),
          ),
        );
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(body: Pi(calculator: calc)),
        ));

        late Finder finderStreamText;
        finderStreamText = find.byKey(const Key('StreamText'));

        expect(finderStreamText, findsOneWidget);
        await tester.pumpAndSettle(const Duration(milliseconds: 4));
        expect(find.text('The latest known value of pi is 3.1'), findsOneWidget);
        await tester.pumpAndSettle(const Duration(milliseconds: 4));
        expect(find.text('The latest known value of pi is 3.14'), findsOneWidget);
        await tester.pumpAndSettle(const Duration(milliseconds: 4));
        expect(find.text('The latest known value of pi is 3.141'), findsOneWidget);
      });
    });
    testWidgets(
      'matches golden file',
      (tester) async {
        await tester.pumpWidget(const MyApp());
        await expectLater(find.byType(MyApp), matchesGoldenFile('goldens/calculator/app.png'));
      },
    );
  });
}
