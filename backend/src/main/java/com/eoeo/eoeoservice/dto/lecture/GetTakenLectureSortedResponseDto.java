package com.eoeo.eoeoservice.dto.lecture;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class GetTakenLectureSortedResponseDto {

    List<GetTakenLectureResponseDto> coreLectures;

    List<GetTakenLectureResponseDto> firstMajor;

    List<GetTakenLectureResponseDto> secondMajor;
}
