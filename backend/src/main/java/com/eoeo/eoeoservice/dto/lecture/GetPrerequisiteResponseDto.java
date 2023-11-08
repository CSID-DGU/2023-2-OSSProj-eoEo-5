package com.eoeo.eoeoservice.dto.lecture;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class GetPrerequisiteResponseDto {

    private Long lectureId;

    private String name;

    private String lectureNumber;

    private Long credit;
}
