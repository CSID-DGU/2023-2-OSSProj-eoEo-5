package com.eoeo.eoeoservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/healthcheck")
public class HealthCheckController {

    @GetMapping("")
    public String hello(){
        return "Hello Hello World!!";
    }

}
