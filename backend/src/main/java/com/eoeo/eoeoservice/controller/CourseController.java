package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.course.CoreCourseCreditRequestDto;
import com.eoeo.eoeoservice.dto.course.CoreCourseCreditResponseDto;
import com.eoeo.eoeoservice.dto.course.CourseLectureListRequestDto;
import com.eoeo.eoeoservice.dto.course.CourseLectureListResponseDto;
import com.eoeo.eoeoservice.service.CourseService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/course")
@RequiredArgsConstructor
public class CourseController {

    private final CourseService courseService;

    @GetMapping("/getcourselectures")
    public List<CourseLectureListResponseDto> getCourseLectures(CourseLectureListRequestDto request){
        return courseService.getCourseLectures(request);
    }

    @GetMapping("/getcorecoursecredit")
    public List<CoreCourseCreditResponseDto> getCoreCourseCredit(CoreCourseCreditRequestDto request){
        return courseService.getCoreCourseCredits(request);
    }

}
