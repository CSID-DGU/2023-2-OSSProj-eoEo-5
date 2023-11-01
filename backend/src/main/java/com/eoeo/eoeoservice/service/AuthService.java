package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.account.Account;
import com.eoeo.eoeoservice.domain.account.AccountRepository;
import com.eoeo.eoeoservice.dto.auth.UserLoginRequestDto;
import com.eoeo.eoeoservice.dto.auth.UserLoginResponseDto;
import com.eoeo.eoeoservice.dto.auth.UserRegisterRequestDto;
import com.eoeo.eoeoservice.dto.auth.UserRegisterResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.Charset;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AccountRepository accountRepository;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public UserRegisterResponseDto register(UserRegisterRequestDto request) throws Exception{

        if(!accountRepository.findByUsername(request.getUsername()).isEmpty()){
            throw new IllegalArgumentException();
        }

        byte[] bytes = new byte[16];
        String salt;

        new Random().nextBytes(bytes);
        salt = new String(bytes, Charset.forName("UTF-8"));

        Account account = Account.builder()
                .username(request.getUsername())
                .name(request.getName())
                .salt(salt)
                .password(passwordEncoder.encode(salt + request.getPassword()))
                .build();

        accountRepository.save(account);


        return UserRegisterResponseDto.builder()
                .id(account.getId())
                .build();

    }

    public UserLoginResponseDto login(UserLoginRequestDto request) throws Exception{
        Account account = accountRepository.findByUsername(request.getUsername()).orElseThrow(() -> new IllegalArgumentException());


        if(!passwordEncoder.matches(account.getSalt()+request.getPassword(), account.getPassword())){
            throw new IllegalArgumentException();
        }

        return UserLoginResponseDto.builder()
                .id(account.getId())
                .build();
    }



}
