package com.eoeo.eoeoservice.dto.faq_management;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AddFaqRequestDto {

    private String question;

    private String answer;

    //A=지원, B=교과, C=학점 인정, D=취업, E=기타
    private String category;

}
