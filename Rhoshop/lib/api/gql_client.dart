import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final createGqlClient = (String apiHost) => ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: HttpLink(uri: apiHost),
      ),
    );
