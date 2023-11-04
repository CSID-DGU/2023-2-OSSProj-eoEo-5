package com.eoeo.eoeoservice.dto.course_management;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddLectureToCourseRequestDto {

    private Long courseId;

    private Long lectureId;

}
