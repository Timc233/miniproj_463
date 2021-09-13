package com.miniproj.miniproj.service;

import com.miniproj.miniproj.entity.ServingSize;

import java.io.IOException;

public interface SearchService {

    String foodSearch(String barcode) throws IOException;

    String foodDetail(String foodIndex) throws IOException;

    ServingSize getServingSize(String fdcId) throws IOException;
}
