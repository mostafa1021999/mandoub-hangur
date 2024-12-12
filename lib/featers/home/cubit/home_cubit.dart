import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/requested_order_model.dart';
import '../home_data_handler.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<RequestedOrderModel> requestedOrders = [];
  Future<void> getRequestedOrders() async {
    emit(HomeLoading());
    final result = await HomeDataHandler.getRequestedOrders();
    result.fold((l) {
      print("error is ${l.errorModel.statusMessage}");

      emit(HomeLoaded());
    }, (r) {
      requestedOrders = r;
      print("RequestedOrders::::>>> ${requestedOrders.length}");

      emit(HomeError());
    });
  }
}
