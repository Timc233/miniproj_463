package com.miniproj.miniproj.vo;

import lombok.Data;

import java.util.List;

@Data
public class FoodDetailVO {
    Integer fdcId;
    String foodName;
    Double servingSize;
    String servingSizeUnit;
    List<FoodNutrientVO> nutrients;
}
