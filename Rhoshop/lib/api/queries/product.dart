final product = """
      query(\$id: String!, \$language: String) {
        product(id: \$id, language: \$language ) {
          id
          name
          description
          image
          price
          oldPrice
          rating
          reviewsCount
        }
      }
      """;
