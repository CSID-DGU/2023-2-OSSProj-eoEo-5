package com.eoeo.eoeoservice.dto.auth;

import io.jsonwebtoken.Claims;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@AllArgsConstructor
@Builder
@Getter
public class RefreshTokenValidationDto {

    private String username;

    private Claims claims;

}
