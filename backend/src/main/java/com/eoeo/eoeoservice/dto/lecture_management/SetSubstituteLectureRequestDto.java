package com.eoeo.eoeoservice.dto.lecture_management;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SetSubstituteLectureRequestDto {

    private Long majorId;

    private Long originalLectureId;

    private Long substituteLectureId;
}
