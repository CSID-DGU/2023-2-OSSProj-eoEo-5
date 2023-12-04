package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.faq_management.AddFaqRequestDto;
import com.eoeo.eoeoservice.service.FaqManagementService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/management/faq")
@RequiredArgsConstructor
public class FaqManagementController {

    private final FaqManagementService faqManagementService;

    @PostMapping("/addfaq")
    public Long addFaq(AddFaqRequestDto request){
        return faqManagementService.addFaq(request);
    }


}
