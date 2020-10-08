final createUser = """
      mutation(\$createUserDto: CreateUserInput!) {
        createUser(createUserInput: \$createUserDto ) {
          id
          name
        }
      }
      """;
