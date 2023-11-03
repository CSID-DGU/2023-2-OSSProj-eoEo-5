package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.lecture_management.AddLectureRequestDto;
import com.eoeo.eoeoservice.dto.lecture_management.SetPrerequisiteRequestDto;
import com.eoeo.eoeoservice.dto.lecture_management.SetSubstituteLectureRequestDto;
import com.eoeo.eoeoservice.service.LectureManagementService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/management/lecture")
@RequiredArgsConstructor
public class LectureManagementController {

    private final LectureManagementService lectureManagementService;

    @PostMapping("/addlecture")
    public Long addLecture(AddLectureRequestDto request){
        return lectureManagementService.addLecture(request);
    }

    @PostMapping("/setprerequisite")
    public Long setPrerequisite(SetPrerequisiteRequestDto request){
        return lectureManagementService.setPrerequisite(request);
    }

    @PostMapping("/setsubstitute")
    public Long setSubstituteLecture(SetSubstituteLectureRequestDto request){
        return lectureManagementService.setSubstituteLecture(request);
    }

}
