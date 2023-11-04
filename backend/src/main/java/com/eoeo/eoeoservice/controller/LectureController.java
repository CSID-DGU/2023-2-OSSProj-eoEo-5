package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.lecture.AddTakenLectureRequestDto;
import com.eoeo.eoeoservice.dto.lecture.GetTakenLectureRequestDto;
import com.eoeo.eoeoservice.dto.lecture.GetTakenLectureResponseDto;
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

    @GetMapping("/getlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenLectures(request);
    }

}
