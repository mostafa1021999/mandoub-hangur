import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Utilities/shared_preferences.dart';

import '../Models/notification_model.dart';
import '../notifications_data_handler.dart';

part 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitial());
  static NotificationsCubit get(context) => BlocProvider.of(context);
  List<NotificationModel> notifications = [];
  Future<void> getNotifications() async {
    emit(NotificationsLoading());
    final result = await NotificationsDataHandler.getAllNotifications();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");

      emit(NotificationsLoaded());
    }, (r) {
      notifications = r;
      print('heeeeeeeeeeeeeeeeeeee.......>>> ${SharedPref.getToken()}');
      print(r.length);

      emit(NotificationsError());
    });
  }
}
