package com.miniproj.miniproj.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Recipe {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String createTime;
    private String updateTime;
    private Integer userId;
    private Integer userAssignedRecipeId;
    private String recipeDescription;
    private Integer fdcId;
    private String foodName;
    private String foodType;
    private Double caloriePerServing;
    private Double servingSize;
    private Double amount;
    private String servingSizeUnit;
}
