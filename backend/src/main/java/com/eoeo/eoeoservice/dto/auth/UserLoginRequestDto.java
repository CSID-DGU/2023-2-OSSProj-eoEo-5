package com.eoeo.eoeoservice.dto.auth;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class UserLoginRequestDto {

    private String username;

    private String password;
}
