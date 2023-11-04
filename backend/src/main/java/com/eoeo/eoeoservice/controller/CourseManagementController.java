package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseCreditRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCourseTypeRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddLectureToCourseRequestDto;
import com.eoeo.eoeoservice.service.CourseManagementService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/management/course")
@RequiredArgsConstructor
public class CourseManagementController {

    private final CourseManagementService courseManagementService;

    @PostMapping("/addcoursetype")
    public Long addCourse(AddCourseTypeRequestDto request){
        return courseManagementService.addCourseType(request);
    }

    @PostMapping("/addcorecourse")
    public Long addCoreCourse(AddCoreCourseRequestDto request){
        return courseManagementService.addCoreCourse(request);
    }

    @PostMapping("/addcorecoursecredit")
    public Long addCoreCourseCredit(AddCoreCourseCreditRequestDto request){
        return courseManagementService.addCoreCourseCredit(request);
    }

    @PostMapping("/addlecturetocourse")
    public Long addLectureToCourse(AddLectureToCourseRequestDto request){
        return courseManagementService.addLectureToCourse(request);
    }


}
