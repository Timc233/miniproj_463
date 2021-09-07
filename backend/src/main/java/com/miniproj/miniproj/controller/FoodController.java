package com.miniproj.miniproj.controller;

import com.miniproj.miniproj.service.RecipeService;
import com.miniproj.miniproj.service.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@RestController
@RequestMapping("/food")
public class FoodController {

    @Autowired
    SearchService searchService;

    @Autowired
    RecipeService recipeService;

    @RequestMapping(value = "/search", method = GET)
    public String search(String barcode) throws IOException {
        return searchService.foodSearch(barcode);
    }

    @RequestMapping(value = "/add", method = POST)
    public String add(String userId, String foodIndex, String recipeId, String recipeDescription) throws IOException {
        return recipeService.add(userId, foodIndex, recipeId, recipeDescription);
    }

    @RequestMapping(value = "/searchRecipe", method = POST)
    public String searchRecipe(String userId){
        return recipeService.searchRecipe(userId);
    }


}
