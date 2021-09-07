package com.miniproj.miniproj.controller;

import com.miniproj.miniproj.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.web.bind.annotation.RequestMethod.*;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/add", method = POST)
    public String add(String userEmail, String userName, String password){
        return userService.add(userEmail, userName, password);
    }

    @RequestMapping(value = "/login", method = POST)
    public String login(String userEmail, String password){
        return userService.login(userEmail, password);
    }


}
