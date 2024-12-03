import 'package:untitled2/Utilities/api_endpoints.dart';
import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';

class OrderBriefDataHandler {
  static Future<Either<Failure,  Map<String, dynamic>>> getStatistics(
      {required String startDate,required String endDate,}) async {
    try {
      Map<String, dynamic> response = await GenericRequest< Map<String, dynamic>>(
        method: HttpRequestHandler.getUri(uri:ApiEndpoints.uri(
            path: ApiEndpoints.deliveryManStatistics,
            queryParameters: {
              'startDate': startDate,
              'endDate': endDate
            }
        ),),
        fromMap: (data) => data,
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
