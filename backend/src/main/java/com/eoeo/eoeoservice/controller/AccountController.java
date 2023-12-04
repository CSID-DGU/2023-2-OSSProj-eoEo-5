package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.account.AccountDataRequestDto;
import com.eoeo.eoeoservice.dto.account.AccountDataResponseDto;
import com.eoeo.eoeoservice.dto.account.LogoutRequestDto;
import com.eoeo.eoeoservice.service.AccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/account")
@RequiredArgsConstructor
public class AccountController {

    private final AccountService accountService;

    @GetMapping("/getaccount")
    public AccountDataResponseDto getAccountData(AccountDataRequestDto request){
        return accountService.getAccountData(request);
    }

    @PostMapping("/logout")
    public Boolean logout(LogoutRequestDto request){
        return accountService.logout(request);
    }
}
