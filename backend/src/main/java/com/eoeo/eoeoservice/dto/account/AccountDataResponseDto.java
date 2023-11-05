package com.eoeo.eoeoservice.dto.account;

import com.eoeo.eoeoservice.domain.major.Major;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class AccountDataResponseDto {

    private Long id;

    private String username;

    private String name;

    private long schoolId;

    private String schoolName;

    private long majorId;

    private String majorName;

    private long secondMajorId;

    private String secondMajorName;

    private long coreCourseId;

    private long requiredCourseId;

    private long selectiveCourseId;

    private long secondRequiredCourseId;

    private long secondSelectiveCourseId;

    private long selectiveCredit;

    private long secondSelectiveCredit;

    public void setSecondMajor(Major major){
        secondMajorId = major.getId();
        secondMajorName = major.getName();
        secondRequiredCourseId = major.getRequiredCourse().getId();
        secondSelectiveCourseId = major.getSelectiveCourse().getId();
        secondSelectiveCredit = major.getSelectiveCourseCredit();
    }

}
