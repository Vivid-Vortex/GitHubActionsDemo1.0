package com.demo.cicd.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/base")
public class RestControllerDemo {

    @GetMapping
    public String getMethod() {
        return "Hello World";
    }
}
