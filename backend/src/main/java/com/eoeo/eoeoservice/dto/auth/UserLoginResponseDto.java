package com.eoeo.eoeoservice.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UserLoginResponseDto {

    private Long id;

    private String username;

    private String name;

    private long schoolId;

    private String schoolName;

    private long majorId;

    private String majorName;

    private long coreCourseId;

    private long requiredCourseId;

    private long selectiveCourseId;

    private long selectiveCredit;

    private String accessToken;

    private String refreshToken;


}
