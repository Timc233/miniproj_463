package com.miniproj.miniproj.vo;

import lombok.Data;

@Data
public class RecipeFoodVO {
    String foodName;
    Double caloriePerServing;
    Double servingSize;
    String servingSizeUnit;
    Double amount;
}
