package com.woniu;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@MapperScan("com.woniu.mapper")
@SpringBootApplication
public class SpringBoorDemo {
	
	public static void main(String[] args) {
		SpringApplication.run(SpringBoorDemo.class, args);
	}

}
