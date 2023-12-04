package com.eoeo.eoeoservice.dto.faq;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Category for each letter
 * A=지원(Support)
 * B=교과(Subject)
 * C=학점 인정(Credit)
 * D=취업(Job)
 * E=기타(Etc)
 */

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class RequestFaqResponseDto {

    List<FaqDto> supportList;
    List<FaqDto> subjectList;
    List<FaqDto> creditList;
    List<FaqDto> jobList;
    List<FaqDto> etcList;

}
