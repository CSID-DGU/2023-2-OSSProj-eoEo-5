package com.eoeo.eoeoservice.dto.course_management;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddCoreCourseCreditRequestDto {

    private Long coreCourseId;

    private Long coreLectureTypeId;

    private Long credit;

}
