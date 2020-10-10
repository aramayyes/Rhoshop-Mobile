import 'package:graphql_flutter/graphql_flutter.dart';

enum ApiError { client, badUserInput, authentication, internalServer }

/// Parses api error (which in our case is graphql exception) and returns an ApiError.
ApiError parseApiError(OperationException exception) {
  if (exception.clientException != null) {
    return ApiError.client;
  } else {
    for (final error in exception.graphqlErrors) {
      if (error.extensions['code'] == 'UNAUTHENTICATED') {
        return ApiError.authentication;
      } else if (error.extensions['code'] == 'BAD_USER_INPUT') {
        return ApiError.badUserInput;
      }
    }
    return ApiError.internalServer;
  }
}
