package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCourseRequestDto;
import com.eoeo.eoeoservice.service.CourseManagementService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/management/course")
@RequiredArgsConstructor
public class CourseManagementController {

    private final CourseManagementService courseManagementService;

    @PostMapping("/addcourse")
    public Long addCourse(@RequestParam AddCourseRequestDto request){
        return courseManagementService.addCourse(request);
    }

    @PostMapping("/addcorecourse")
    public Long addCoreCourse(@RequestParam AddCoreCourseRequestDto request){
        return courseManagementService.addCoreCourse(request);
    }

}
