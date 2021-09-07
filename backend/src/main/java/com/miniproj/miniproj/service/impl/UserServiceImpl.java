package com.miniproj.miniproj.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.miniproj.miniproj.entity.User;
import com.miniproj.miniproj.mapper.UserMapper;
import com.miniproj.miniproj.service.UserService;
import com.miniproj.miniproj.util.JsonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired private UserMapper userMapper;


    @Override
    public String add(String userEmail, String userName, String password) {

        if(userEmail == null){return JsonResponse.fail("User Email vacant").toJson();};
        if(userName == null){return JsonResponse.fail("User name vacant").toJson();};
        if(password == null){return JsonResponse.fail("Password vacant").toJson();};

        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUserEmail, userEmail);
        User user =  userMapper.selectOne(queryWrapper);

        if(user!=null){
            return JsonResponse.fail("User already existed").toJson();
        }

        User newUser = new User();
        newUser.setUserEmail(userEmail);
        newUser.setUserName(userName);
        newUser.setPassword(password);

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formatTime = format.format(new Date());
        newUser.setCreateTime(formatTime);
        newUser.setUpdateTime(formatTime);
        userMapper.insert(newUser);

        return JsonResponse.success("User registration success").toJson();
    }

    @Override
    public String login(String userEmail, String password) {

        if(userEmail == null){return JsonResponse.fail("User Email vacant").toJson();};
        if(password == null){return JsonResponse.fail("Password vacant").toJson();};

        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper();
        queryWrapper.eq(User::getUserEmail, userEmail);
        User user = userMapper.selectOne(queryWrapper);
        if(user == null){
            return JsonResponse.fail("User not existed").toJson();
        }
        if(!user.getPassword().equals(password)){
            return JsonResponse.fail("Password incorrect").toJson();
        }

        Integer userId = user.getId();
        Gson gson = new Gson();
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("userId", userId);

        return JsonResponse.success(jsonObject).toJson();
    }
}
