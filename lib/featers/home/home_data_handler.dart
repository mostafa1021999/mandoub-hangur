import 'package:untitled2/Utilities/api_endpoints.dart';

import '../../Core/Api/generic_request.dart';
import '../../Core/Api/http_request.dart';
import '../../Core/Error/exceptions.dart';
import '../../Core/Error/failures.dart';
import '../../Core/Network/custom_either.dart';
import '../Notifications/Models/notification_model.dart';

class HomeDataHandler {
  static Future<Either<Failure, List<NotificationModel>>>
      getRequestedOrders() async {
    try {
      List<NotificationModel> response =
          await GenericRequest<NotificationModel>(
        method: HttpRequestHandler.get(
          url: ApiEndpoints.requestedOrders,
        ),
        fromMap: NotificationModel.fromJson,
      ).getList(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
