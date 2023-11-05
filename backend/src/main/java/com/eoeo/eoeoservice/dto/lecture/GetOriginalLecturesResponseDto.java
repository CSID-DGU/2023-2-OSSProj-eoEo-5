package com.eoeo.eoeoservice.dto.lecture;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class GetOriginalLecturesResponseDto {

    private Long substituteId;

    private Long originalLectureId;

    private String originalLectureName;

    private String originalLectureNumber;

    private Long originalLectureCredit;
}
