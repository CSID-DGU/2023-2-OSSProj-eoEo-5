package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.lecture.*;
import com.eoeo.eoeoservice.service.LectureService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/lecture")
@RequiredArgsConstructor
public class LectureController {

    private final LectureService lectureService;

    @PostMapping("/addlecturetaken")
    public Long addLectureTaken(@RequestBody AddTakenLectureRequestDto request){
        return lectureService.addTakenLecture(request);
    }

    @PostMapping("/addlecturestaken")
    public Boolean addLecturesTaken(@RequestBody AddTakenLecturesRequestDto request){
        return lectureService.addTakenLectures(request);
    }

    @GetMapping("/getlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenLectures(request);
    }

    @GetMapping("/getcorelecturetaken")
    public List<GetTakenLectureResponseDto> getTakenCoreLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenCoreLectures(request);
    }

    @GetMapping("/getfirstmajorlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenFirstMajorLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenFirstMajorLectures(request);
    }

    @GetMapping("/getsecondmajorlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenSecondMajorLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenSecondMajorLectures(request);
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
