import 'package:untitled2/Utilities/api_endpoints.dart';

import '../../../../Core/Api/generic_request.dart';
import '../../../../Core/Api/http_request.dart';
import '../../../../Core/Error/exceptions.dart';
import '../../../../Core/Error/failures.dart';
import '../../../../Core/Network/custom_either.dart';
import '../../../../model/get_rider_data_model.dart';

class UserDataDataHandler {
  UserDataDataHandler._();
  static final UserDataDataHandler _instance = UserDataDataHandler._();
  factory UserDataDataHandler() => _instance;

  static Future<Either<Failure, RiderData>> getUserData() async {
    try {
      RiderData response = await GenericRequest<RiderData>(
        method: HttpRequestHandler.get(
          url: ApiEndpoints.getUserData,
        ),
        fromMap: (data) {
          return RiderData.fromJson(data);
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
