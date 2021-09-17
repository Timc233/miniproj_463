package com.miniproj.miniproj.APIOperation.entity;

import lombok.Data;

import java.util.List;

@Data
public class FdcReturn {
    public int totalHits;
    public int currentPage;
    public int totalPages;
    public List<Integer> pageList;
    public FoodSearchCriteria foodSearchCriteria;
    public List<Food> foods;
    public Aggregations aggregations;

    public String getFoodName(){
        if(this.getTotalHits()==0){
            return null;
        }

        return this.getFoods().get(0).getDescription();
    }

    public Double getCalorie(){
        if(this.getTotalHits()==0){
            return null;
        }

        List<FoodNutrient> foodNutrientList = this.getFoods().get(0).foodNutrients;
        Double Calorie = null;
        for(FoodNutrient x:foodNutrientList){
            if(x.getNutrientId()==1008){
                Calorie = x.getValue();
            }
        }
        return Calorie;
    }

    public Integer getFdcId(){
        return this.getFoods().get(0).getFdcId();
    }

    public String getFoodType(){
        return this.getFoodSearchCriteria().getFoodTypes().get(0);
    }
}





