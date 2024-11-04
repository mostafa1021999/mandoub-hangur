// import '../../Core/Api/generic_request.dart';
// import '../../Core/Api/http_request.dart';
// import '../../Core/Error/exceptions.dart';
// import '../../Core/Error/failures.dart';
// import '../../Core/Network/custom_either.dart';
// import '../../Utilities/api_endpoints.dart';
//
// class OrdersDataHandler {
//   static Future<Either<Failure, YourModel>> acceptOrder(
//       {required String orderID}) async {
//     try {
//       YourModel response = await GenericRequest<YourModel>(
//         method: HttpRequestHandler.postJson(
//             url: '${ApiEndpoints.orders}/$orderID/accept', bodyJson: {}),
//         fromMap: YourModel.fromJson,
//       ).getObject(printBody: false);
//       return Either.right(response);
//     } on ServerException catch (failure) {
//       return Either.left(
//         ServerFailure(failure.errorMessageModel),
//       );
//     }
//   }
// }
