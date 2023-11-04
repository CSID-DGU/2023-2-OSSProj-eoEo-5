package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.core_course.CoreCourseRepository;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureType;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureTypeRepository;
import com.eoeo.eoeoservice.domain.course_type.CourseType;
import com.eoeo.eoeoservice.domain.course_type.CourseTypeRepository;
import com.eoeo.eoeoservice.domain.major.Major;
import com.eoeo.eoeoservice.domain.major.MajorRepository;
import com.eoeo.eoeoservice.domain.school.School;
import com.eoeo.eoeoservice.domain.school.SchoolRepository;
import com.eoeo.eoeoservice.dto.core_management.AddCoreLectureTypeRequestDto;
import com.eoeo.eoeoservice.dto.core_management.AddMajorRequestDto;
import com.eoeo.eoeoservice.dto.core_management.AddSchoolRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class CoreManagementService {

    private final SchoolRepository schoolRepository;
    private final CoreLectureTypeRepository coreLectureTypeRepository;
    private final CoreCourseRepository coreCourseRepository;
    private final CourseTypeRepository courseTypeRepository;
    private final MajorRepository majorRepository;


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

    @Transactional
    public Long addMajor(AddMajorRequestDto request){
        School school = schoolRepository.findById(request.getSchoolId())
                .orElseThrow(() -> new NoSuchElementException("No such school"));

        CoreCourse coreCourse = coreCourseRepository.findById(request.getCoreCourseId())
                .orElseThrow(() -> new NoSuchElementException("No such core course"));

        CourseType requiredCourse = courseTypeRepository.findById(request.getRequiredCourseId())
                .orElseThrow(() -> new NoSuchElementException("No such course"));

        CourseType selectiveCourse = courseTypeRepository.findById(request.getRequiredCourseId())
                .orElseThrow(() -> new NoSuchElementException("No such course"));

        Major major = Major.builder()
                .name(request.getName())
                .school(school)
                .coreCourse(coreCourse)
                .requiredCourse(requiredCourse)
                .selectiveCourse(selectiveCourse)
                .selectiveCourseCredit(request.getSelectiveCourseCredit())
                .build();

        majorRepository.save(major);

        return major.getId();
    }

}
