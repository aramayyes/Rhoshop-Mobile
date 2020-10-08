import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient createGqlClient({String apiHost, String token = ''}) {
  apiHost = apiHost ?? DotEnv().env['API_HOST'];

  return GraphQLClient(
    cache: InMemoryCache(),
    link: AuthLink(
      getToken: () => 'Bearer $token',
    ).concat(HttpLink(uri: apiHost)),
  );
}
