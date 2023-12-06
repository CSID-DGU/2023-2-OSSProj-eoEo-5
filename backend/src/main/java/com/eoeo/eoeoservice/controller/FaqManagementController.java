package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.faq_management.AddFaqRequestDto;
import com.eoeo.eoeoservice.service.FaqManagementService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/management/faq")
@RequiredArgsConstructor
public class FaqManagementController {

    private final FaqManagementService faqManagementService;

    @ApiOperation(value="FAQ 추가 API",notes="카테고리 코드: A=지원, B=교과, C=학점 인정, D=취업, E=기타")
    @PostMapping("/addfaq")
    public Long addFaq(AddFaqRequestDto request){
        return faqManagementService.addFaq(request);
    }


}
