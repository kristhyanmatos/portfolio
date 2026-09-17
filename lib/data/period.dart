const _months = [
  'jan', 'fev', 'mar', 'abr', 'mai', 'jun', //
  'jul', 'ago', 'set', 'out', 'nov', 'dez',
];

/// Meses entre [start] e [end], contando os dois meses (como no LinkedIn).
int monthsInclusive(DateTime start, DateTime end) =>
    (end.year - start.year) * 12 + end.month - start.month + 1;

/// `27` -> `2 anos e 3 meses`.
String formatDuration(int months) {
  final years = months ~/ 12;
  final rest = months % 12;
  return [
    if (years > 0) '$years ${years == 1 ? 'ano' : 'anos'}',
    if (rest > 0) '$rest ${rest == 1 ? 'mês' : 'meses'}',
  ].join(' e ');
}

String formatMonth(DateTime date) => '${_months[date.month - 1]} ${date.year}';

/// `dez 2023 – atual · 2 anos e 10 meses`. Sem [end], conta até [now].
String formatPeriod(DateTime start, DateTime? end, {DateTime? now}) {
  final until = end ?? now ?? DateTime.now();
  final label = end == null ? 'atual' : formatMonth(end);
  final duration = formatDuration(monthsInclusive(start, until));
  return '${formatMonth(start)} – $label · $duration';
}
