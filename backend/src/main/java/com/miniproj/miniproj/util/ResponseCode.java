package com.miniproj.miniproj.util;

public enum ResponseCode {

    OK(200, "Request success"),
    FAIL(400, "Request fail")

    ;


    private int code;
    private String codeMessage;

    private ResponseCode(int code, String codeMessage){
        this.code = code;
        this.codeMessage = codeMessage;
    }

    public int getResponseCode(){
        return code;
    }

    public String getCodeMessage(){
        return codeMessage;
    }



}
