package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.faq.Faq;
import com.eoeo.eoeoservice.domain.faq.FaqRepository;
import com.eoeo.eoeoservice.dto.faq.FaqDto;
import com.eoeo.eoeoservice.dto.faq.RequestFaqResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FaqService {

    private final FaqRepository faqRepository;

    //A=지원, B=교과, C=학점 인정, D=취업, E=기타
    public RequestFaqResponseDto getFaq() {

        List<FaqDto> supportList = new LinkedList<>();
        List<FaqDto> subjectList = new LinkedList<>();
        List<FaqDto> creditList = new LinkedList<>();
        List<FaqDto> jobList = new LinkedList<>();
        List<FaqDto> etcList = new LinkedList<>();

        List<Faq> faqList = faqRepository.findAllByIsDeleted(false);

        for (Faq faq : faqList) {
            String category = faq.getCategory();
            FaqDto faqDto = FaqDto.builder()
                    .question(faq.getQuestion())
                    .answer(faq.getAnswer())
                    .build();
            switch (category) {
                case "A":
                    supportList.add(faqDto);
                    break;
                case "B":
                    subjectList.add(faqDto);
                    break;
                case "C":
                    creditList.add(faqDto);
                    break;
                case "D":
                    jobList.add(faqDto);
                    break;
                case "E":
                    etcList.add(faqDto);
                    break;
            }
        }

        return RequestFaqResponseDto.builder()
                .supportList(supportList)
                .subjectList(subjectList)
                .creditList(creditList)
                .jobList(jobList)
                .etcList(etcList)
                .build();
    }


}
