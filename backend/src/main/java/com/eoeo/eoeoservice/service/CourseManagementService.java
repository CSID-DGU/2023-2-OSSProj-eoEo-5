package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.core_course.CoreCourseRepository;
import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCredit;
import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCreditRepository;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureType;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureTypeRepository;
import com.eoeo.eoeoservice.domain.course.Course;
import com.eoeo.eoeoservice.domain.course.CourseRepository;
import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseCreditRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCourseRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class CourseManagementService {

    private final CourseRepository courseRepository;
    private final CoreCourseRepository coreCourseRepository;
    private final CoreLectureTypeRepository coreLectureTypeRepository;
    private final CoreCourseCreditRepository coreCourseCreditRepository;



    @Transactional
    public Long addCourse(AddCourseRequestDto request){
        Course course = Course.builder()
                .name(request.getName())
                .build();

        courseRepository.save(course);

        return course.getId();

    }

    @Transactional
    public Long addCoreCourse(AddCoreCourseRequestDto request){
        CoreCourse coreCourse = CoreCourse.builder()
                .name(request.getName())
                .build();

        coreCourseRepository.save(coreCourse);

        return coreCourse.getId();
    }

    @Transactional
    public Long addCoreCourseCredit(AddCoreCourseCreditRequestDto request) {
        CoreCourse coreCourse = coreCourseRepository.findById(request.getCoreCourseId())
                .orElseThrow(() -> new NoSuchElementException("No such core course"));

        CoreLectureType coreLectureType = coreLectureTypeRepository.findById(request.getCoreLectureTypeId())
                .orElseThrow(() -> new NoSuchElementException("No such core lecture type"));

        CoreCourseCredit coreCourseCredit = CoreCourseCredit.builder()
                .coreCourse(coreCourse)
                .coreLectureType(coreLectureType)
                .credit(request.getCredit())
                .build();

        coreCourseCreditRepository.save(coreCourseCredit);

        return coreCourseCredit.getId();
    }

}
