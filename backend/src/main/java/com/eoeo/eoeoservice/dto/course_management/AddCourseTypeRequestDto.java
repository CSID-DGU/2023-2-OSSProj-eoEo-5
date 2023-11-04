package com.eoeo.eoeoservice.dto.course_management;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddCourseTypeRequestDto {

    private String name;

    private Boolean isRequired;

}
