package com.eoeo.eoeoservice.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@AllArgsConstructor
@Getter
@Builder
public class RequestNewTokenResponseDto {

    private boolean isValidated;

    private String accessToken;

    private String refreshToken;
}
