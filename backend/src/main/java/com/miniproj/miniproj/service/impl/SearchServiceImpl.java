package com.miniproj.miniproj.service.impl;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.miniproj.miniproj.APIOperation.APIRequest;
import com.miniproj.miniproj.APIOperation.entity.FdcReturn;
import com.miniproj.miniproj.entity.ServingSize;
import com.miniproj.miniproj.service.SearchService;
import com.miniproj.miniproj.util.JsonResponse;
import com.miniproj.miniproj.vo.BrandedFoodVO;
import com.miniproj.miniproj.vo.FoodDetailVO;
import com.miniproj.miniproj.vo.FoodNutrientVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class SearchServiceImpl implements SearchService {

    @Autowired APIRequest apiRequest;

    @Override
    public String foodSearch(String barcode) throws IOException {
        FdcReturn fdcReturn = new FdcReturn();
        fdcReturn = apiRequest.SearchBranded(barcode);
        if(fdcReturn.getTotalHits()==0){
            return JsonResponse.fail("Food not existed in FDC database").toJson();
        }
        BrandedFoodVO brandedFoodVO = new BrandedFoodVO();
        brandedFoodVO.setFoodName(fdcReturn.getFoodName());
        brandedFoodVO.setCaloriesPerServing(fdcReturn.getCalorie());

        return JsonResponse.success(brandedFoodVO).toJson();
    }

    @Override
    public String foodDetail(String foodIndex) throws IOException {
        FdcReturn fdcReturn = apiRequest.SearchBranded(foodIndex);
        if(fdcReturn.getTotalHits()==0){
            return JsonResponse.fail("Food not existed in FDC database").toJson();
        }
//        FDC ID
        Integer fdcId = fdcReturn.getFdcId();
        String foodResult = apiRequest.getFood(fdcId.toString());

        JsonParser parser = new JsonParser();
        JsonElement jsonTree = parser.parse(foodResult);

        if(!jsonTree.isJsonObject()){
            return JsonResponse.fail("Fail to parse json object").toJson();
        }

        JsonObject foodDetail = jsonTree.getAsJsonObject();
//        Food Name
        String foodName = foodDetail.get("description").getAsString();
//        Serving Size
        Double servingSize = foodDetail.get("servingSize").getAsDouble();
//        Serving size unit
        String servingSizeUnit = foodDetail.get("servingSizeUnit").getAsString();
//        Nutrients
        JsonObject nutrients = foodDetail.get("labelNutrients").getAsJsonObject();
        Set<Map.Entry<String, JsonElement>> nutrientEntry = nutrients.entrySet();
        List<FoodNutrientVO> foodNutrientVOList = new ArrayList<>();
//        JsonObject tres = nutrients.get(0).getAsJsonObject();
        nutrientEntry.forEach(
                x -> {
                    FoodNutrientVO foodNutrientVO = new FoodNutrientVO();
                    foodNutrientVO.setAttribute(x.getKey());
                    Double value = x.getValue().getAsJsonObject().get("value").getAsDouble();
                    foodNutrientVO.setValue(value);
                    foodNutrientVOList.add(foodNutrientVO);
                }
        );

        FoodDetailVO foodDetailVO = new FoodDetailVO();
        foodDetailVO.setFdcId(fdcId);
        foodDetailVO.setFoodName(foodName);
        foodDetailVO.setServingSize(servingSize);
        foodDetailVO.setServingSizeUnit(servingSizeUnit);
        foodDetailVO.setNutrients(foodNutrientVOList);

        return JsonResponse.success(foodDetailVO).toJson();
    }

    @Override
    public ServingSize getServingSize(String fdcId) throws IOException {
//      retrieve food data
        String foodResult = apiRequest.getFood(fdcId);

        JsonParser parser = new JsonParser();
        JsonElement jsonTree = parser.parse(foodResult);

        JsonObject foodDetail = jsonTree.getAsJsonObject();

//        Serving Size
        Double servingSize = foodDetail.get("servingSize").getAsDouble();
        String servingSizeUnit = foodDetail.get("servingSizeUnit").getAsString();

        ServingSize res = new ServingSize();
        res.setServingSize(servingSize);
        res.setServingSizeUnit(servingSizeUnit);
        return res;
    }
}
