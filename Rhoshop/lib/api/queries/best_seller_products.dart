final bestSellerProducts = """
      query(\$count: Int!, \$language: String) {
        bestSellerProducts(count: \$count, language: \$language ) {
          id
          name
          image
          price
        }
      }
      """;
