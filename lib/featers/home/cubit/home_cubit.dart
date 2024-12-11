import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Notifications/Models/notification_model.dart';
import '../home_data_handler.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<NotificationModel> requestedOrders = [];
  Future<void> getNotifications() async {
    emit(HomeLoading());
    final result = await HomeDataHandler.getRequestedOrders();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");

      emit(HomeLoaded());
    }, (r) {
      requestedOrders = r;
      print(r.length);

      emit(HomeError());
    });
  }
}
