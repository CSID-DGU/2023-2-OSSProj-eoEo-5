package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.account.LogoutRequestDto;
import com.eoeo.eoeoservice.dto.auth.*;
import com.eoeo.eoeoservice.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register")
    public UserRegisterResponseDto register(@RequestBody UserRegisterRequestDto request) {
        return authService.register(request);
    }

    @PostMapping("/login")
    public UserLoginResponseDto login(@RequestBody UserLoginRequestDto request) {
        return authService.login(request);
    }

    @PostMapping("/newtoken")
    public RequestNewTokenResponseDto requestNewToken(@RequestBody RequestNewTokenRequestDto request){
        return authService.requestNewToken(request);
    }

    @GetMapping("/majorlist")
    public List<AuthMajorResponseDto> getMajorList(){
        return authService.getMajorList();
    }

    @PostMapping("/logout")
    public Boolean logout(LogoutRequestDto request){
        return authService.logout(request);
    }

}
