final updateUser = """
      mutation(\$updateUserDto: UpdateUserInput!) {
        updateUser(updateUserInput: \$updateUserDto ) {
          id
          name
          phoneNumber
          email
        }
      }
      """;
