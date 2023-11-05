package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.lecture.*;
import com.eoeo.eoeoservice.service.LectureService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/lecture")
@RequiredArgsConstructor
public class LectureController {

    private final LectureService lectureService;

    @PostMapping("/addlecturetaken")
    public Long addLectureTaken(AddTakenLectureRequestDto request){
        return lectureService.addTakenLecture(request);
    }

    @PostMapping("/addlecturestaken")
    public Boolean addLecturesTaken(AddTakenLecturesRequestDto request){
        return lectureService.addTakenLectures(request);
    }

    @GetMapping("/getlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenLectures(request);
    }

    @GetMapping("/getprerequisites")
    public List<GetPrerequisiteResponseDto> getPrerequisites(GetPrerequisiteRequestDto request){
        return lectureService.getPrerequisites(request);
    }

    @GetMapping("/getsubstitutes")
    public List<GetSubstituteLectureResponseDto> getSubstitutes(GetSubstituteLectureRequestDto request){
        return lectureService.getSubstitutes(request);
    }

    @GetMapping("/getoriginallectures")
    public List<GetOriginalLecturesResponseDto> getOriginalLectures(GetOriginalLecturesRequestDto request){
        return lectureService.getOriginalLectures(request);
    }

}
