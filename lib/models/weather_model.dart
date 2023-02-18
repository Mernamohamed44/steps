class WeatherModel {
  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentWeather,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  final latitude;
  final longitude;
  final generationtimeMs;
  final utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final elevation;
  final CurrentWeather? currentWeather;
  final HourlyUnits? hourlyUnits;
  final Hourly? hourly;
  final DailyUnits? dailyUnits;
  final Daily? daily;

  WeatherModel copyWith({
    latitude,
    longitude,
    generationtimeMs,
    utcOffsetSeconds,
    String? timezone,
    String? timezoneAbbreviation,
    elevation,
    CurrentWeather? currentWeather,
    HourlyUnits? hourlyUnits,
    Hourly? hourly,
    DailyUnits? dailyUnits,
    Daily? daily,
  }) {
    return WeatherModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      generationtimeMs: generationtimeMs ?? this.generationtimeMs,
      utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
      timezone: timezone ?? this.timezone,
      timezoneAbbreviation: timezoneAbbreviation ?? this.timezoneAbbreviation,
      elevation: elevation ?? this.elevation,
      currentWeather: currentWeather ?? this.currentWeather,
      hourlyUnits: hourlyUnits ?? this.hourlyUnits,
      hourly: hourly ?? this.hourly,
      dailyUnits: dailyUnits ?? this.dailyUnits,
      daily: daily ?? this.daily,
    );
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      latitude: json["latitude"] ?? 0.0,
      longitude: json["longitude"] ?? 0.0,
      generationtimeMs: json["generationtime_ms"] ?? 0.0,
      utcOffsetSeconds: json["utc_offset_seconds"] ?? 0.0,
      timezone: json["timezone"] ?? "",
      timezoneAbbreviation: json["timezone_abbreviation"] ?? "",
      elevation: json["elevation"] ?? 0.0,
      currentWeather: json["current_weather"] == null
          ? null
          : CurrentWeather.fromJson(json["current_weather"]),
      hourlyUnits: json["hourly_units"] == null
          ? null
          : HourlyUnits.fromJson(json["hourly_units"]),
      hourly: json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]),
      dailyUnits: json["daily_units"] == null
          ? null
          : DailyUnits.fromJson(json["daily_units"]),
      daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
    );
  }
}

class CurrentWeather {
  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.time,
  });

  final temperature;
  final windspeed;
  final winddirection;
  final weathercode;
  final String time;

  CurrentWeather copyWith({
    temperature,
    windspeed,
    winddirection,
    weathercode,
    String? time,
  }) {
    return CurrentWeather(
      temperature: temperature ?? this.temperature,
      windspeed: windspeed ?? this.windspeed,
      winddirection: winddirection ?? this.winddirection,
      weathercode: weathercode ?? this.weathercode,
      time: time ?? this.time,
    );
  }

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: json["temperature"] ?? 0.0,
      windspeed: json["windspeed"] ?? 0.0,
      winddirection: json["winddirection"] ?? 0.0,
      weathercode: json["weathercode"] ?? 0.0,
      time: json["time"] ?? "",
    );
  }
}

class Daily {
  Daily({
    required this.time,
    required this.sunrise,
    required this.sunset,
  });

  final List<DateTime> time;
  final List<String> sunrise;
  final List<String> sunset;

  Daily copyWith({
    List<DateTime>? time,
    List<String>? sunrise,
    List<String>? sunset,
  }) {
    return Daily(
      time: time ?? this.time,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      time: json["time"] == null
          ? []
          : List<DateTime>.from(
              json["time"]!.map((x) => x == null ? null : DateTime.parse(x))),
      sunrise: json["sunrise"] == null
          ? []
          : List<String>.from(json["sunrise"]!.map((x) => x)),
      sunset: json["sunset"] == null
          ? []
          : List<String>.from(json["sunset"]!.map((x) => x)),
    );
  }
}

class DailyUnits {
  DailyUnits({
    required this.time,
    required this.sunrise,
    required this.sunset,
  });

  final String time;
  final String sunrise;
  final String sunset;

  DailyUnits copyWith({
    String? time,
    String? sunrise,
    String? sunset,
  }) {
    return DailyUnits(
      time: time ?? this.time,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json["time"] ?? "",
      sunrise: json["sunrise"] ?? "",
      sunset: json["sunset"] ?? "",
    );
  }
}

class Hourly {
  Hourly({
    required this.time,
    required this.temperature2M,
    required this.precipitation,
    required this.windspeed10M,
    required this.winddirection120M,
  });

  final List<String> time;
  final List temperature2M;
  final List precipitation;
  final List windspeed10M;
  final List winddirection120M;

  Hourly copyWith({
    List<String>? time,
    List? temperature2M,
    List? precipitation,
    List? windspeed10M,
    List? winddirection120M,
  }) {
    return Hourly(
      time: time ?? this.time,
      temperature2M: temperature2M ?? this.temperature2M,
      precipitation: precipitation ?? this.precipitation,
      windspeed10M: windspeed10M ?? this.windspeed10M,
      winddirection120M: winddirection120M ?? this.winddirection120M,
    );
  }

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      time: json["time"] == null
          ? []
          : List<String>.from(json["time"]!.map((x) => x)),
      temperature2M: json["temperature_2m"] == null
          ? []
          : List<double>.from(json["temperature_2m"]!.map((x) => x)),
      precipitation: json["precipitation"] == null
          ? []
          : List<double>.from(json["precipitation"]!.map((x) => x)),
      windspeed10M: json["windspeed_10m"] == null
          ? []
          : List<double>.from(json["windspeed_10m"]!.map((x) => x)),
      winddirection120M: json["winddirection_120m"] == null
          ? []
          : List<int>.from(json["winddirection_120m"]!.map((x) => x)),
    );
  }
}

class HourlyUnits {
  HourlyUnits({
    required this.time,
    required this.temperature2M,
    required this.precipitation,
    required this.windspeed10M,
    required this.winddirection120M,
  });

  final String time;
  final String temperature2M;
  final String precipitation;
  final String windspeed10M;
  final String winddirection120M;

  HourlyUnits copyWith({
    String? time,
    String? temperature2M,
    String? precipitation,
    String? windspeed10M,
    String? winddirection120M,
  }) {
    return HourlyUnits(
      time: time ?? this.time,
      temperature2M: temperature2M ?? this.temperature2M,
      precipitation: precipitation ?? this.precipitation,
      windspeed10M: windspeed10M ?? this.windspeed10M,
      winddirection120M: winddirection120M ?? this.winddirection120M,
    );
  }

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json["time"] ?? "",
      temperature2M: json["temperature_2m"] ?? "",
      precipitation: json["precipitation"] ?? "",
      windspeed10M: json["windspeed_10m"] ?? "",
      winddirection120M: json["winddirection_120m"] ?? "",
    );
  }
}
