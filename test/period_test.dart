import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/period.dart';

void main() {
  group('monthsInclusive', () {
    test('conta o mês de início e o de fim', () {
      expect(monthsInclusive(DateTime(2024, 1), DateTime(2024, 1)), 1);
      expect(monthsInclusive(DateTime(2020, 8), DateTime(2021, 8)), 13);
      expect(monthsInclusive(DateTime(2019, 3), DateTime(2020, 7)), 17);
    });
  });

  group('formatDuration', () {
    test('usa singular e plural', () {
      expect(formatDuration(1), '1 mês');
      expect(formatDuration(5), '5 meses');
      expect(formatDuration(12), '1 ano');
      expect(formatDuration(13), '1 ano e 1 mês');
      expect(formatDuration(52), '4 anos e 4 meses');
    });
  });

  group('formatPeriod', () {
    test('experiência encerrada', () {
      expect(
        formatPeriod(DateTime(2019, 3), DateTime(2020, 7)),
        'mar 2019 – jul 2020 · 1 ano e 5 meses',
      );
    });

    test('experiência atual conta até hoje', () {
      expect(
        formatPeriod(DateTime(2023, 12), null, now: DateTime(2026, 9, 17)),
        'dez 2023 – atual · 2 anos e 10 meses',
      );
    });
  });
}
