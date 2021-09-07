package com.miniproj.miniproj.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class User {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String createTime;
    private String updateTime;
    private String userName;
    private String password;
    private String userEmail;

}
