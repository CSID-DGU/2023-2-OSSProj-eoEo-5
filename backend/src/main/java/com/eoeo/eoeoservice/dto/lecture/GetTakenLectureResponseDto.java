package com.eoeo.eoeoservice.dto.lecture;

import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.domain.prerequisite.Prerequisite;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class GetTakenLectureResponseDto {

    private Long id;

    private String name;

    private String lectureNumber;

    private Boolean isCoreLecture;

    private Long coreLectureTypeId;

    private Long courseTypeId;

    private Long credit;

    private Boolean isSubstitute;

    private Long originalLectureId;

    private String originalLectureName;

    private String originalLectureNumber;

    public void setOriginalLecture(Prerequisite prerequisite){
        Lecture originalLecture = prerequisite.getLecture();
        originalLectureId = originalLecture.getId();
        originalLectureName = originalLecture.getName();
        originalLectureNumber = originalLecture.getLectureNumber();
    }

    public void setCoreCourse(Lecture lecture){
        isCoreLecture = lecture.isCoreLecture();
        coreLectureTypeId = lecture.getCoreLectureType().getId();
    }

    public void setCourseId(Lecture lecture){
        courseTypeId = lecture.getCourseType().getId();
    }
}