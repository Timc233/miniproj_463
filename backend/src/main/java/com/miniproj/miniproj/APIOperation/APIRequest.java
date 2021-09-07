package com.miniproj.miniproj.APIOperation;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.miniproj.miniproj.APIOperation.entity.FdcReturn;
import okhttp3.*;

import org.springframework.stereotype.Service;

import java.io.IOException;


@Service
public class APIRequest {


    public FdcReturn SearchBranded(String barcode, String apiKey) throws IOException{
        Gson gson = new Gson();
        JsonObject params = new JsonObject();
        params.addProperty("query", barcode);
        JsonArray dataType = new JsonArray();
        dataType.add("Branded");
        params.add("dataType", dataType);
        String requestJson = gson.toJson(params);
        OkHttpClient client = new OkHttpClient();
        RequestBody body = RequestBody.create(MediaType.get("application/json; charset=utf-8"), requestJson);
//        FIXME request url used here
        String url = "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=" + apiKey;

        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .build();
        Response response = client.newCall(request).execute();
        FdcReturn fdcReturn = gson.fromJson(response.body().string(), FdcReturn.class);

        return fdcReturn;
    }


}
