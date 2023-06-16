import 'package:steps/models/weather_model.dart';

abstract class StepsState {}

class InitialState extends StepsState {}

class ChangeNavBottomState extends StepsState {}

class SignUpStateLoadingState extends StepsState {}

class SignUpStateSuccessState extends StepsState {}

class SignUpStateErrorState extends StepsState {
  final String errorMsg;
  SignUpStateErrorState(this.errorMsg);
}

class SignInStateLoadingState extends StepsState {}

class SignInStateSuccessState extends StepsState {}

class SignInStateErrorState extends StepsState {
  final String errorMsg;
  SignInStateErrorState(this.errorMsg);
}

class CreateUserStateLoadingState extends StepsState {}

class CreateUserSuccessState extends StepsState {}

class CreateUserErrorState extends StepsState {}

class SignInWithGoogleStateLoadingState extends StepsState {}

class SignInWithGoogleStateSuccessState extends StepsState {}

class SignInWithGoogleStateErrorState extends StepsState {
  final String errorMsg;
  SignInWithGoogleStateErrorState(this.errorMsg);
}

class GetWeatherDataLoadingState extends StepsState {}

class GetWeatherDataSuccessState extends StepsState {}

class GetWeatherDataStateErrorState extends StepsState {
  final String errorMsg;
  GetWeatherDataStateErrorState(this.errorMsg);
}

class EnableBluetoothState extends StepsState {}

class UnEnableBluetoothState extends StepsState {}

class AngleConstrainsState extends StepsState {}

class SendAngleSuccessState extends StepsState {}

class SendAngleErrorState extends StepsState {}

class UnShowWarningState extends StepsState {}

class SuccessState extends StepsState {

}

class ErrorState extends StepsState {
  String errorMsg;
  ErrorState(this.errorMsg);
}
