final orders = """
      query(\$language: String) {
        orders {
          id
          date
          product(language: \$language ) {
            id
            name
            image
            price
          }
          productSize
          productColor
          productCount
        }
      }
      """;
