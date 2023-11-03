package com.eoeo.eoeoservice.dto.auth;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class RequestNewTokenRequestDto {

    private String refreshToken;

}
