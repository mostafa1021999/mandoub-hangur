part of 'mandoub_cubit.dart';

@immutable
sealed class MandoubState {}

final class MandoubInitial extends MandoubState {}
class GetMap extends MandoubState {}
class GetCurrentPosition extends MandoubState {}
class OtherState extends MandoubState {}

