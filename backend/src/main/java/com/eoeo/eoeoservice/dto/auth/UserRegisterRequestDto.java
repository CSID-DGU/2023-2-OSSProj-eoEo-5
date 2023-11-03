package com.eoeo.eoeoservice.dto.auth;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class UserRegisterRequestDto {

    private String username;

    private String password;

    private String name;

    private Long majorId;

    private Long secondMajorId;

    private Boolean isSecondMajor;

}
