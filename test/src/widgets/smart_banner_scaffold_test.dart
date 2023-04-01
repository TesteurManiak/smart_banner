import 'package:flutter_test/flutter_test.dart';
import 'package:smart_banner/src/widgets/smart_banner_scaffold.dart';

import '../../utils/testable_widget.dart';

void main() {
  group('SmartBannerScaffold', () {
    testWidgets(
      'should find a SmartBannerScope in the widget tree if isShown is true',
      (tester) async {
        await tester.pumpWidget(
          const TestableSmartBannerScaffold(isShown: true),
        );

        expect(find.byType(SmartBannerScope), findsOneWidget);
      },
    );

    testWidgets(
      'should not find a SmartBannerScope in the widget tree if isShown is false',
      (tester) async {
        await tester.pumpWidget(
          const TestableSmartBannerScaffold(isShown: false),
        );

        expect(find.byType(SmartBannerScope), findsNothing);
      },
    );
  });
}
