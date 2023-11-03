package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.core_course.CoreCourseRepository;
import com.eoeo.eoeoservice.domain.course.Course;
import com.eoeo.eoeoservice.domain.course.CourseRepository;
import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCourseRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CourseManagementService {

    private final CourseRepository courseRepository;
    private final CoreCourseRepository coreCourseRepository;



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

}
