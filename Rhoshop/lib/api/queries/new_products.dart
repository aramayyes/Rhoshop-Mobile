final newProducts = """
      query(\$count: Int!, \$language: String) {
        newProducts(count: \$count, language: \$language ) {
          id
          name
          image
          price
        }
      }
      """;
