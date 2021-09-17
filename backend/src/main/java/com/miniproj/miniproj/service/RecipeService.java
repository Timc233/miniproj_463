package com.miniproj.miniproj.service;

import java.io.IOException;

public interface RecipeService {

    String add(String userId, String foodIndex, String recipeId, String recipeDescription, Double amount) throws IOException;

    String deleteFood(String userId, String recipeId);

    String deleteRecipe(String userId, String userDefinedId);

    String searchRecipe(String userId);

    Integer newRecipeId(String userId);
}
