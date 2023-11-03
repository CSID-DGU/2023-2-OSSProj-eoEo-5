package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureType;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureTypeRepository;
import com.eoeo.eoeoservice.domain.school.School;
import com.eoeo.eoeoservice.domain.school.SchoolRepository;
import com.eoeo.eoeoservice.dto.core_management.AddCoreLectureTypeRequestDto;
import com.eoeo.eoeoservice.dto.core_management.AddSchoolRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CoreManagementService {

    private final SchoolRepository schoolRepository;
    private final CoreLectureTypeRepository coreLectureTypeRepository;

    @Transactional
    public Long addSchool(AddSchoolRequestDto request){
        School school = School.builder()
                .name(request.getName())
                .build();

        schoolRepository.save(school);

        return school.getId();
    }

    @Transactional
    public Long addCoreLectureType(AddCoreLectureTypeRequestDto request){
        CoreLectureType coreLectureType = CoreLectureType.builder()
                .name(request.getName())
                .build();

        coreLectureTypeRepository.save(coreLectureType);

        return coreLectureType.getId();
    }

}
