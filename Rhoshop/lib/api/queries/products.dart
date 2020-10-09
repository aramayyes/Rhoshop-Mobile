final productSearchSuggestions = """
      query(\$filter: FilterProductsInput, \$language: String) {
        products(filter: \$filter, language: \$language ) {
          id
          name
          image
        }
      }
      """;
