package com.miniproj.miniproj.APIOperation.entity;

import lombok.Data;

import java.util.List;

@Data
public class FoodSearchCriteria {
    public List<String> dataType;
    public String query;
    public String generalSearchInput;
    public int pageNumber;
    public int numberOfResultsPerPage;
    public int pageSize;
    public boolean requireAllWords;
    public List<String> foodTypes;
}
