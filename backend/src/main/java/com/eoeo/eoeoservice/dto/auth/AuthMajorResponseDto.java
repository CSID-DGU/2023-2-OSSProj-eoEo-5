package com.eoeo.eoeoservice.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class AuthMajorResponseDto {

    private Long majorId;
    private String name;

}
