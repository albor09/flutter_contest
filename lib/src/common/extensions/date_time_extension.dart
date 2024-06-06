const _month = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь'
];

extension DateTimeExtension on DateTime {
  String dMMMMhmm() {
    return '${day} ${_month[month]}, ${hour}:${minute > 9 ? minute : "0${minute}"}';
  }
}
