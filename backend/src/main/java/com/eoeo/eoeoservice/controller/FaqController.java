package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.faq.RequestFaqResponseDto;
import com.eoeo.eoeoservice.service.FaqService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/faq")
@RequiredArgsConstructor
public class FaqController {

    private final FaqService faqService;

    @GetMapping("/getfaq")
    public RequestFaqResponseDto getFaq(){
        return faqService.getFaq();
    }

}
