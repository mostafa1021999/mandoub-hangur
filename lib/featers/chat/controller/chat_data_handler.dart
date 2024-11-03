import 'package:untitled2/Utilities/api_endpoints.dart';
import 'package:untitled2/model/chat_model.dart';

import '../../../Core/Api/generic_request.dart';
import '../../../Core/Api/http_request.dart';
import '../../../Core/Error/exceptions.dart';
import '../../../Core/Error/failures.dart';
import '../../../Core/Network/custom_either.dart';

class ChatDataHandler {
  static Future<Either<Failure, ChatModel>> getChat() async {
    try {
      ChatModel response = await GenericRequest<ChatModel>(
        method: HttpRequestHandler.get(
          url: ApiEndpoints.chat,
        ),
        fromMap: ChatModel.fromJson,
      ).getResponse(printBody: false);
      return Either.right(response);
    } on ServerException catch (failure) {
      return Either.left(
        ServerFailure(failure.errorMessageModel),
      );
    }
  }
}
