package com.eoeo.eoeoservice.dto.lecture;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddTakenLecturesRequestDto {

    private Long accountId;

    private List<LectureTakenDto> lectures;

}

