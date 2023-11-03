package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.account.Account;
import com.eoeo.eoeoservice.domain.account.AccountRepository;
import com.eoeo.eoeoservice.domain.major.Major;
import com.eoeo.eoeoservice.domain.major.MajorRepository;
import com.eoeo.eoeoservice.domain.school.School;
import com.eoeo.eoeoservice.domain.school.SchoolRepository;
import com.eoeo.eoeoservice.dto.auth.*;
import com.eoeo.eoeoservice.security.JwtProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.Charset;
import java.util.LinkedList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AccountRepository accountRepository;
    private final MajorRepository majorRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtProvider jwtProvider;

    @Transactional
    public UserRegisterResponseDto register(UserRegisterRequestDto request) throws Exception{

        Major major;
        Major secondMajor;

        if(!accountRepository.findByUsername(request.getUsername()).isEmpty()){
            throw new IllegalArgumentException();
        }

        major = majorRepository.findById(request.getMajorId())
                .orElseThrow(() -> new NoSuchElementException("No such major"));



        byte[] bytes = new byte[16];
        String salt;

        new Random().nextBytes(bytes);
        salt = new String(bytes, Charset.forName("UTF-8"));

        Account account = Account.builder()
                .username(request.getUsername())
                .name(request.getName())
                .major(major)
                .isSecondMajor(request.getIsSecondMajor())
                .salt(salt)
                .password(passwordEncoder.encode(salt + request.getPassword()))
                .build();

        if(request.getIsSecondMajor()){
            secondMajor = majorRepository.findById(request.getSecondMajorId())
                    .orElseThrow(() -> new NoSuchElementException("No such major"));

            account.setSecondMajor(secondMajor);
        }

        accountRepository.save(account);


        return UserRegisterResponseDto.builder()
                .id(account.getId())
                .build();

    }

    @Transactional
    public UserLoginResponseDto login(UserLoginRequestDto request) {
        Account account = accountRepository.findByUsername(request.getUsername()).orElseThrow(() -> new IllegalArgumentException());


        if(!passwordEncoder.matches(account.getSalt()+request.getPassword(), account.getPassword())){
            throw new IllegalArgumentException();
        }

        String validationToken = jwtProvider.createValidationToken();
        account.setValidationToken(passwordEncoder.encode(validationToken));

        UserLoginResponseDto userLoginResponseDto = UserLoginResponseDto.builder()
                .id(account.getId())
                .name(account.getName())
                .username(account.getUsername())
                .schoolId(account.getMajor().getSchool().getId())
                .schoolName(account.getMajor().getSchool().getName())
                .majorId(account.getMajor().getId())
                .majorName(account.getMajor().getName())
                .accessToken(jwtProvider.createAccessToken(account.getUsername()))
                .refreshToken(jwtProvider.createRefreshToken(account.getUsername(), validationToken))
                .build();

        if(account.getIsSecondMajor()){
            userLoginResponseDto.setSecondMajor(account.getSecondMajor());
        }

        return userLoginResponseDto;
    }

    @Transactional
    public RequestNewTokenResponseDto requestNewToken(RequestNewTokenRequestDto request){

        RefreshTokenValidationDto validationDto;
        Account account;
        try{
            validationDto = jwtProvider.extractClaimAndUsername(request.getRefreshToken());
            account = accountRepository.findByUsername(validationDto.getUsername())
                    .orElseThrow(() -> new UsernameNotFoundException("No such user."));

        } catch(Exception e){
            return RequestNewTokenResponseDto.builder()
                    .isValidated(false)
                    .build();
        }

        boolean validationResult = jwtProvider.validateRefreshToken(validationDto, account, passwordEncoder);

        if(validationResult){
            String validationToken = jwtProvider.createValidationToken();
            account.setValidationToken(passwordEncoder.encode(validationToken));
            return RequestNewTokenResponseDto.builder()
                    .isValidated(true)
                    .accessToken(jwtProvider.createAccessToken(account.getUsername()))
                    .refreshToken(jwtProvider.createRefreshToken(account.getUsername(), validationToken))
                    .build();
        } else{
            return RequestNewTokenResponseDto.builder()
                    .isValidated(false)
                    .build();
        }

    }

    public List<AuthMajorResponseDto> getMajorList(){
        List<AuthMajorResponseDto> response = new LinkedList<AuthMajorResponseDto>();

        List<Major> majorList = majorRepository.findAll();

        for(Major major : majorList){
            response.add(AuthMajorResponseDto.builder()
                    .majorId(major.getId())
                    .name(major.getName())
                    .build());
        }

        return response;
    }



}
