package com.miniproj.miniproj.util;

import com.google.gson.GsonBuilder;

public class JsonResponse<T> {
    private int responseCode;
    private String message;
    private T data;

    public JsonResponse(int code, String message, T data){
        this.responseCode = code;
        this.message = message;
        this.data = data;
    }

    public static <T> JsonResponse<T> success(T data){
        return new JsonResponse<T>(ResponseCode.OK.getResponseCode(), ResponseCode.OK.getCodeMessage(), data);
    }

    public static <T> JsonResponse <T> fail(T data){
        return new JsonResponse<T>(ResponseCode.FAIL.getResponseCode(), ResponseCode.FAIL.getCodeMessage(), data);
    }

    public String toJson(){
        GsonBuilder gsonBuilder = new GsonBuilder();
        gsonBuilder.serializeNulls();
        return gsonBuilder.create().toJson(this);
    }
}
