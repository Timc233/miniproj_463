package com.miniproj.miniproj.service;

public interface UserService {

    String add(String userEmail, String userName, String password);

    String login(String userEmail, String password);
}
