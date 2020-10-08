final signIn = """
      mutation(\$signInDto: SignInInput!) {
        signIn(signInInput: \$signInDto ) {
          access_token
          email
        }
      }
      """;
