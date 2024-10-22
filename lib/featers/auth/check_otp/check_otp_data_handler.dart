import 'package:untitled2/Utilities/api_endpoints.dart';
import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';

class CheckOtpDataHandler {
  static Future<Either<Failure,  Map<String, dynamic>>> checkOTP(
      {required String residencyNumber,required String otpCode}) async {
    try {
      Map<String, dynamic> response = await GenericRequest< Map<String, dynamic>>(
        method: HttpRequestHandler.postJson(url: '${ApiEndpoints.checkCodeOtp}/$residencyNumber', bodyJson: {
          'otp':otpCode
        }),
        fromMap: (data) {
          if(data["status"] == true ){
            return {
              "success": true,
              "token": data["token"]
            };
          }else {
            return {"success": false};
          }
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
