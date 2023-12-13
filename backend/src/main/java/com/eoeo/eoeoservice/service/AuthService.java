package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.account.Account;
import com.eoeo.eoeoservice.domain.account.AccountRepository;
import com.eoeo.eoeoservice.domain.account.AccountRole;
import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCredit;
import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCreditRepository;
import com.eoeo.eoeoservice.domain.course_lectures.CourseLectures;
import com.eoeo.eoeoservice.domain.course_lectures.CourseLecturesRepository;
import com.eoeo.eoeoservice.domain.major.Major;
import com.eoeo.eoeoservice.domain.major.MajorRepository;
import com.eoeo.eoeoservice.dto.account.LogoutRequestDto;
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
    private final CourseLecturesRepository courseLecturesRepository;
    private final CoreCourseCreditRepository coreCourseCreditRepository;
    private final MajorRepository majorRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtProvider jwtProvider;

    @Transactional
    public UserRegisterResponseDto register(UserRegisterRequestDto request) {

        Major major;
        Major secondMajor;

        if(!accountRepository.findByUsernameAndIsDeleted(request.getUsername(), false).isEmpty()){
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
                .role(AccountRole.USER)
                .build();

        if(request.getIsSecondMajor()){
            secondMajor = majorRepository.findByIdAndIsDeleted(request.getSecondMajorId(), false)
                    .orElseThrow(() -> new NoSuchElementException("No such major"));

            if(request.getMajorId().equals(request.getSecondMajorId())){
                throw new IllegalArgumentException("First Major and Second Major cannot be same");
            }

            account.setSecondMajor(secondMajor);
        }

        accountRepository.save(account);


        return UserRegisterResponseDto.builder()
                .id(account.getId())
                .build();

    }

    @Transactional
    public UserLoginResponseDto login(UserLoginRequestDto request) {
        Account account = accountRepository.findByUsernameAndIsDeleted(request.getUsername(), false).orElseThrow(() -> new IllegalArgumentException("No such Username"));
        List<CourseLectures> firstMajorRequiredLectureList = courseLecturesRepository.findAllByCourseTypeAndIsDeleted(account.getMajor().getRequiredCourse(), false);
        List<CoreCourseCredit> coreCourseCreditList = coreCourseCreditRepository.findAllByCoreCourseAndIsDeleted(account.getMajor().getCoreCourse(), false);
        long firstMajorRequiredCredit = 0;
        long coreCourseCredit = 0;

        for(CourseLectures courseLecture : firstMajorRequiredLectureList){
            firstMajorRequiredCredit = firstMajorRequiredCredit + courseLecture.getLecture().getCredit();
        }

        for(CoreCourseCredit coreCredit : coreCourseCreditList){
            coreCourseCredit = coreCourseCredit + coreCredit.getCredit();
        }


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
                .coreCourseId(account.getMajor().getCoreCourse().getId())
                .requiredCourseId(account.getMajor().getRequiredCourse().getId())
                .selectiveCourseId(account.getMajor().getSelectiveCourse().getId())
                .selectiveCredit(account.getMajor().getSelectiveCourseCredit())
                .totalCredit(account.getMajor().getTotalCredit())
                .totalFirstMajorCredit(firstMajorRequiredCredit + account.getMajor().getSelectiveCourseCredit())
                .totalCoreLectureCredit(coreCourseCredit)
                .accessToken(jwtProvider.createAccessToken(account.getUsername()))
                .refreshToken(jwtProvider.createRefreshToken(account.getUsername(), validationToken))
                .build();

        if(account.getIsSecondMajor()){
            List<CourseLectures> secondMajorRequiredLectureList = courseLecturesRepository.findAllByCourseTypeAndIsDeleted(account.getSecondMajor().getRequiredCourse(), false);
            long secondMajorRequiredCredit = 0;
            for(CourseLectures courseLecture : secondMajorRequiredLectureList){
                secondMajorRequiredCredit = secondMajorRequiredCredit + courseLecture.getLecture().getCredit();
            }
            userLoginResponseDto.setSecondMajor(account.getSecondMajor(), secondMajorRequiredCredit);
        }

        return userLoginResponseDto;
    }

    @Transactional
    public RequestNewTokenResponseDto requestNewToken(RequestNewTokenRequestDto request){

        RefreshTokenValidationDto validationDto;
        Account account;
        try{
            validationDto = jwtProvider.extractClaimAndUsername(request.getRefreshToken());
            account = accountRepository.findByUsernameAndIsDeleted(validationDto.getUsername(), false)
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
        List<AuthMajorResponseDto> response = new LinkedList<>();

        List<Major> majorList = majorRepository.findAllByIsDeleted(false);

        for(Major major : majorList){
            response.add(AuthMajorResponseDto.builder()
                    .majorId(major.getId())
                    .name(major.getName())
                    .build());
        }

        return response;
    }

    @Transactional
    public Boolean logout(LogoutRequestDto request){
        Account account = accountRepository.findByIdAndIsDeleted(request.getId(), false).orElseThrow(() -> new NoSuchElementException("No such user"));
        account.logout();

        return true;
    }



}
