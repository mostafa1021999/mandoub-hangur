import 'package:untitled2/Utilities/api_endpoints.dart';

import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';

class LoginDataHandler {
  static Future<Either<Failure, String>> login(
      {required String residencyNumber, required String password}) async {
    try {
      String response = await GenericRequest<String>(
        method: HttpRequestHandler.postJson(url: ApiEndpoints.login, bodyJson: {
          'residencyNumber': residencyNumber,
          'password': password
        }),
        fromMap: (data) => data["token"],
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
