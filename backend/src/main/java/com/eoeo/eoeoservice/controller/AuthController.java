package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.auth.UserLoginRequestDto;
import com.eoeo.eoeoservice.dto.auth.UserLoginResponseDto;
import com.eoeo.eoeoservice.dto.auth.UserRegisterRequestDto;
import com.eoeo.eoeoservice.dto.auth.UserRegisterResponseDto;
import com.eoeo.eoeoservice.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register")
    public UserRegisterResponseDto register(@RequestBody UserRegisterRequestDto request) throws Exception{
        return authService.register(request);
    }

    @PostMapping("/login")
    public UserLoginResponseDto login(@RequestBody UserLoginRequestDto request) throws Exception {
        return authService.login(request);
    }

}
