package com.miniproj.miniproj.APIOperation.entity;

import lombok.Data;

@Data
public class  FoodNutrient {
    public int nutrientId;
    public String nutrientName;
    public String nutrientNumber;
    public String unitName;
    public String derivationCode;
    public String derivationDescription;
    public double value;
}
