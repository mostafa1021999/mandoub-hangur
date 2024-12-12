import 'package:untitled2/Utilities/api_endpoints.dart';
import 'package:untitled2/featers/home/Models/requested_order_model.dart';

import '../../Core/Api/generic_request.dart';
import '../../Core/Api/http_request.dart';
import '../../Core/Error/exceptions.dart';
import '../../Core/Error/failures.dart';
import '../../Core/Network/custom_either.dart';

class HomeDataHandler {
  static Future<Either<Failure, List<RequestedOrderModel>>>
      getRequestedOrders() async {
    try {
      List<RequestedOrderModel> response =
          await GenericRequest<RequestedOrderModel>(
        method: HttpRequestHandler.get(
          url: ApiEndpoints.requestedOrders,
        ),
        fromMap: RequestedOrderModel.fromJson,
      ).getList(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
