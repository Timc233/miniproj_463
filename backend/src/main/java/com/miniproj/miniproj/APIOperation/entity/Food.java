package com.miniproj.miniproj.APIOperation.entity;

import lombok.Data;

import java.util.List;

@Data
public class Food {
    public int fdcId;
    public String description;
    public String lowercaseDescription;
    public String dataType;
    public String gtinUpc;
    public String publishedDate;
    public String brandOwner;
    public String brandName;
    public String subbrandName;
    public String ingredients;
    public String marketCountry;
    public String foodCategory;
    public String allHighlightFields;
    public double score;
    public List<FoodNutrient> foodNutrients;
}
