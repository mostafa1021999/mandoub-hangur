import 'package:untitled2/Utilities/api_endpoints.dart';
import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';

class NewPasswordDataHandler {
  static Future<Either<Failure,  bool>> checkOTP(
      {required String password,required String confirmPassword,required String token}) async {
    try {
      bool response = await GenericRequest< bool>(
        method: HttpRequestHandler.patchJson(
            url: ApiEndpoints.changePassword, bodyJson: {
          "password": password,
          "confirmPassword": confirmPassword
        }),
        fromMap: (data) {
          return true;
        },
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
