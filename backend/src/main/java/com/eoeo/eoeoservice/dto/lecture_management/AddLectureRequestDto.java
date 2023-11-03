package com.eoeo.eoeoservice.dto.lecture_management;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddLectureRequestDto {

    private String name;

    private boolean isCoreLecture;

    private String LectureNumber;

    private Long courseId;

    private Long coreLectureTypeId;

    private Long credit;

}
