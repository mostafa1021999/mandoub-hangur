part of 'rider_cubit.dart';

@immutable
sealed class MandoubState {}

final class MandoubInitial extends MandoubState {}

class GetMap extends MandoubState {}

class GetCurrentPosition extends MandoubState {}

class OtherState extends MandoubState {}

class ChangeLanguageSuccess extends MandoubState {}

class Reload extends MandoubState {}

class ChangeMode extends MandoubState {}

class SetPassword extends MandoubState {}

class LoginLoading extends MandoubState{}

class LoginSuccess extends MandoubState{}

class LoginError extends MandoubState{}

class GetRiderLoading extends MandoubState{}

class GetRiderSuccess extends MandoubState{}

class GetRiderError extends MandoubState{}





