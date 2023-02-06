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