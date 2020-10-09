const notifications = """
      query(\$language: String) {
        notifications(language: \$language ) {
          id
          message
          date
        }
      }
      """;
