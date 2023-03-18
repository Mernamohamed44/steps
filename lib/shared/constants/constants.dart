import 'dart:math';

String? token;
const signUp = '/';
const signIn = 'signIn';
const dashboard = 'dashboard';
String url =
    'https://api.open-meteo.com/v1/forecast?latitude=31.04&longitude=31.38&hourly=temperature_2m,precipitation,windspeed_10m,winddirection_120m&daily=sunrise,sunset&current_weather=true&timezone=Africa%2FCairo';
final yearStart = DateTime(2022, 12, 31);
final dateNow = DateTime.now();
final numDayInYear = dateNow.difference(yearStart).inDays;
double segma = -23.45 * cos(360 * (numDayInYear + 10) / 365);
int alfa = (15 * (DateTime.now().hour) - 12);

