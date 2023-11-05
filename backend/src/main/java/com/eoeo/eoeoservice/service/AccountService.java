package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.account.Account;
import com.eoeo.eoeoservice.domain.account.AccountRepository;
import com.eoeo.eoeoservice.dto.account.AccountDataRequestDto;
import com.eoeo.eoeoservice.dto.account.AccountDataResponseDto;
import com.eoeo.eoeoservice.dto.auth.UserLoginRequestDto;
import com.eoeo.eoeoservice.dto.auth.UserLoginResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;


    public AccountDataResponseDto getAccountData(AccountDataRequestDto request) {
        Account account = accountRepository.findByIdAndIsDeleted(request.getAccountId(), false).orElseThrow(() -> new IllegalArgumentException());


        AccountDataResponseDto accountDataResponseDto = AccountDataResponseDto.builder()
                .id(account.getId())
                .name(account.getName())
                .username(account.getUsername())
                .schoolId(account.getMajor().getSchool().getId())
                .schoolName(account.getMajor().getSchool().getName())
                .majorId(account.getMajor().getId())
                .majorName(account.getMajor().getName())
                .build();

        if(account.getIsSecondMajor()){
            accountDataResponseDto.setSecondMajor(account.getSecondMajor());
        }

        return accountDataResponseDto;
    }

}
