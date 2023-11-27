package com.eoeo.eoeoservice.dto.lecture;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddTakenLectureRequestDto {

    private Long accountId;

    private Long lectureId;

    private Boolean isCoreLecture;

    private Boolean isSecondMajor;

    private Boolean isSubstitute;

    private Long substituteId;

}
