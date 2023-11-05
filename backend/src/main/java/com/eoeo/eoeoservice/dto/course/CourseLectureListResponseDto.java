package com.eoeo.eoeoservice.dto.course;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class CourseLectureListResponseDto {

    private Long lectureId;
    private String lectureName;
    private String lectureNumber;
    private Long credit;

}
