package com.miniproj.miniproj.vo;

import lombok.Data;

import java.util.List;

@Data
public class RecipeVO {
    Integer userDefinedRecipeId;
    String recipeDescription;
    Double totalCalories;
    List<RecipeFoodVO> foods;
}
