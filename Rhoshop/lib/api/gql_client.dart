import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient createGqlClient({String gqlHost, String token = ''}) {
  gqlHost = gqlHost ?? DotEnv().env['API_GQL'];

  final noCachePolicies = Policies(
    fetch: FetchPolicy.noCache,
  );

  return GraphQLClient(
    cache: InMemoryCache(),
    defaultPolicies: DefaultPolicies(
      mutate: noCachePolicies,
      watchQuery: noCachePolicies,
      query: noCachePolicies,
    ),
    link: AuthLink(
      getToken: () => 'Bearer $token',
    ).concat(HttpLink(uri: gqlHost)),
  );
}
