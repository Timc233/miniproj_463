package com.miniproj.miniproj.service;

import java.io.IOException;

public interface RecipeService {

    String add(String userId, String foodIndex, String recipeId, String recipeDescription) throws IOException;

    String searchRecipe(String userId);

    Integer newRecipeId(String userId);
}
