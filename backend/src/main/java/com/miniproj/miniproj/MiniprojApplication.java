package com.miniproj.miniproj;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.miniproj.miniproj.mapper")
public class MiniprojApplication {

	public static void main(String[] args) {
		SpringApplication.run(MiniprojApplication.class, args);
	}

}
