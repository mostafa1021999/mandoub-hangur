import '../../Core/Api/generic_request.dart';
import '../../Core/Api/http_request.dart';
import '../../Core/Error/exceptions.dart';
import '../../Core/Error/failures.dart';
import '../../Core/Network/custom_either.dart';
import '../../Utilities/api_endpoints.dart';
import 'Models/accept_order_model.dart';

class OrdersDataHandler {
  static Future<Either<Failure, AcceptOrderModel>> acceptOrder(
      {required String orderID}) async {
    try {
      AcceptOrderModel response = await GenericRequest<AcceptOrderModel>(
        method: HttpRequestHandler.postJson(
            url: '${ApiEndpoints.orders}/$orderID/accept', bodyJson: {}),
        fromMap: (data) {
          return AcceptOrderModel.fromJson(data);
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }

  // static Future<Either<Failure, AcceptOrderModel>> acceptOrder(
  //     {required String orderID}) async {
  //   try {
  //     AcceptOrderModel response =
  //         await GenericRequest<AcceptOrderModel>(
  //       method: HttpRequestHandler.postJson(
  //           url: '${ApiEndpoints.orders}/$orderID/accept', bodyJson: {}),
  //       fromMap: (data) {
  //         return AcceptOrderModel.fromJson(data);
  //       },
  //     ).getResponse(printBody: false);
  //     return Either.right(
  //       AcceptOrderModel.fromJson(response),
  //     );
  //   } on ServerException catch (failure) {
  //     return Either.left(
  //       ServerFailure(failure.errorMessageModel),
  //     );
  //   }
  // }
}
