package com.eoeo.eoeoservice.dto.lecture;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DeleteTakenLectureRequestDto {

    private Long userId;

    private String lectureNumber;

}
