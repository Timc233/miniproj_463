package com.miniproj.miniproj.service.impl;

import com.miniproj.miniproj.APIOperation.APIRequest;
import com.miniproj.miniproj.APIOperation.entity.FdcReturn;
import com.miniproj.miniproj.service.SearchService;
import com.miniproj.miniproj.util.JsonResponse;
import com.miniproj.miniproj.vo.BrandedFoodVO;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class SearchServiceImpl implements SearchService {

    @Override
    public String foodSearch(String barcode) throws IOException {
        FdcReturn fdcReturn = new FdcReturn();
        APIRequest apiRequest = new APIRequest();

//        FIXME apikey used here
//        apikey is hidden on GitHub
        fdcReturn = apiRequest.SearchBranded(barcode, "");
        BrandedFoodVO brandedFoodVO = new BrandedFoodVO();
        brandedFoodVO.setFoodName(fdcReturn.getFoodName());
        brandedFoodVO.setCaloriesPerServing(fdcReturn.getCalorie());

        return JsonResponse.success(brandedFoodVO).toJson();
    }
}
