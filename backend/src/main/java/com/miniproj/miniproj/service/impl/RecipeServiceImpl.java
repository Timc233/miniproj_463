package com.miniproj.miniproj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.miniproj.miniproj.APIOperation.APIRequest;
import com.miniproj.miniproj.APIOperation.entity.FdcReturn;
import com.miniproj.miniproj.entity.Recipe;
import com.miniproj.miniproj.mapper.RecipeMapper;
import com.miniproj.miniproj.service.RecipeService;
import com.miniproj.miniproj.util.JsonResponse;
import com.miniproj.miniproj.vo.RecipeFoodVO;
import com.miniproj.miniproj.vo.RecipeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class RecipeServiceImpl implements RecipeService {

    @Autowired
    RecipeMapper recipeMapper;

    @Autowired
    APIRequest apiRequest;

//    TODO add amount in unit of serving to params
    @Override
    public String add(String userId, String foodIndex, String recipeId, String recipeDescription) throws IOException {
        Recipe recipe = new Recipe();

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formatTime = format.format(new Date());
        recipe.setCreateTime(formatTime);
        recipe.setUpdateTime(formatTime);

        recipe.setUserId(Integer.parseInt(userId));

        Integer finalRecipeId;
        if(recipeId.isEmpty()){
            finalRecipeId = newRecipeId(userId);
        }else{
            finalRecipeId = Integer.parseInt(recipeId);
        }
        recipe.setUserAssignedRecipeId(finalRecipeId);


        recipe.setRecipeDescription(recipeDescription);

        FdcReturn fdcReturn = apiRequest.SearchBranded(foodIndex, "kFRF4l6mKydFQnBzloWLFEezeaTNpzewOjJpgxVq");

        recipe.setFdcId(fdcReturn.getFdcId());
        recipe.setFoodName(fdcReturn.getFoodName());
        recipe.setFoodType(fdcReturn.getFoodType());
        recipe.setCaloriePerServing(fdcReturn.getCalorie());

//        TODO Figure out food amount by serving size and serving size
//        recipe.setAmount();
//        recipe.setServingSize();
        recipeMapper.insert(recipe);
        return JsonResponse.success("Food add to recipe successful").toJson();
    }

    @Override
    public String searchRecipe(String userId) {
        LambdaQueryWrapper<Recipe> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Recipe::getUserId, userId).orderByAsc(Recipe::getUserAssignedRecipeId);
        List<Recipe> recipeList = recipeMapper.selectList(queryWrapper);
        Integer recipeId = null;
        List<RecipeVO> recipeVOList = new ArrayList<>();
        RecipeVO recipeVO = new RecipeVO();
        List<RecipeFoodVO> recipeFoodVOList = new ArrayList<>();
        for(Recipe x : recipeList){
            RecipeFoodVO recipeFoodVO = new RecipeFoodVO();
            recipeFoodVO.setFoodName(x.getFoodName());
            recipeFoodVO.setCaloriePerServing(x.getCaloriePerServing());
            recipeFoodVO.setAmountInServing(x.getAmount());
            if(x.getUserAssignedRecipeId()!=recipeId){
                if(recipeId == null){
                    recipeId = x.getUserAssignedRecipeId();
                }else{
                    //save the previous recipe to the list
                    recipeVO.setFoods(recipeFoodVOList);
                    recipeVOList.add(recipeVO);
                    //initialize a new recipe
                    recipeVO = new RecipeVO();
                    recipeFoodVOList = new ArrayList<>();
                    recipeId = x.getUserAssignedRecipeId();
                }
            }

            //add current foodVO to food list
            recipeFoodVOList.add(recipeFoodVO);
            recipeVO.setRecipeId(x.getUserAssignedRecipeId());
            recipeVO.setRecipeDescription(x.getRecipeDescription());
//            TODO Figure out serving size and total calories
//            recipeVO.setTotalCalories();
        }

//        Wrap up with the last food list
        recipeVO.setFoods(recipeFoodVOList);
        recipeVOList.add(recipeVO);

        return JsonResponse.success(recipeVOList).toJson();
    }

    @Override
    public Integer newRecipeId(String userId) {

        LambdaQueryWrapper<Recipe> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Recipe::getUserId, userId).orderByDesc(Recipe::getUserAssignedRecipeId);

        List<Recipe> recipeList = new ArrayList<>();
        recipeList = recipeMapper.selectList(queryWrapper);
        Integer newRecipeId = recipeList.get(0).getUserAssignedRecipeId()+1;
        return newRecipeId;
    }
}
