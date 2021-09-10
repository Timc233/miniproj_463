package com.miniproj.miniproj.APIOperation;

import com.google.gson.*;
import com.miniproj.miniproj.APIOperation.entity.FdcReturn;
import okhttp3.*;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;


@Service
public class APIRequest {

    @Value("${fdcapi.token}")
    String token;

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

    public String getFood(String FdcId){
        HttpUrl url = new HttpUrl.Builder()
                .scheme("https")
                .host("api.nal.usda.gov")
                .addPathSegment("fdc/v1/food")
                .addPathSegment(FdcId)
                .addQueryParameter("api_key", token)
                .build();
//        TODO Finish this
        return null;
    }

    public String getRequest(String url) throws IOException {
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url(url)
                .build();
        Call call = client.newCall(request);
        Response response = call.execute();
//        TODO Clean this
//        JsonParser jsonParser = new JsonParser();
//        JsonElement jsonElement = parser.parse(response.body().string());
        return response.body().string();
    }


}
