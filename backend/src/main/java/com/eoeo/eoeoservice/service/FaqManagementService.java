package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.faq.Faq;
import com.eoeo.eoeoservice.domain.faq.FaqRepository;
import com.eoeo.eoeoservice.dto.faq_management.AddFaqRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;


@Service
@RequiredArgsConstructor
public class FaqManagementService {

    private final FaqRepository faqRepository;

    private final List<String> categoryLetters = new ArrayList<>(
            Stream.of("A","B","C","D","E")
                    .collect(Collectors.toList())
    );

    //A=지원, B=교과, C=학점 인정, D=취업, E=기타
    public Long addFaq(AddFaqRequestDto request){


        if(!categoryLetters.contains(request.getCategory())){
            throw new IllegalArgumentException("No such category value");
        }

        Faq faq = Faq.builder()
                .question(request.getQuestion())
                .answer(request.getAnswer())
                .category(request.getCategory())
                .build();

        faqRepository.save(faq);
        return faq.getId();
    }

}
