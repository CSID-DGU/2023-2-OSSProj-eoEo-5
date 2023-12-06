package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.lecture.*;
import com.eoeo.eoeoservice.service.LectureService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/lecture")
@RequiredArgsConstructor
public class LectureController {

    private final LectureService lectureService;

    @ApiOperation(
            value = "기수강 과목 추가(단건)",
            notes = "기수강 과목 단건 추가 Api"
    )
    @PostMapping("/addlecturetaken")
    public Long addLectureTaken(@RequestBody AddTakenLectureRequestDto request){
        return lectureService.addTakenLecture(request);
    }

    @ApiOperation(
            value = "기수강 과목 추가(여러건)",
            notes = "기수강 과목 리스트를 통해 여러건 추가"
    )
    @PostMapping("/addlecturestaken")
    public Boolean addLecturesTaken(@RequestBody AddTakenLecturesRequestDto request){
        return lectureService.addTakenLectures(request);
    }

    @ApiOperation(
            value = "기수강 과목 전체 조회"
    )
    @GetMapping("/getlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenLectures(request);
    }

    @ApiOperation(value = "기수강 과목 전체 조회 (분류됨)")
    @GetMapping("/getlecturetakensorted")
    public GetTakenLectureSortedResponseDto getTakenLecturesSorted(GetTakenLectureRequestDto request){
        return lectureService.getTakenLecturesSorted(request);
    }

    @ApiOperation(value = "기수강 과목 중 교양만 조회")
    @GetMapping("/getcorelecturetaken")
    public List<GetTakenLectureResponseDto> getTakenCoreLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenCoreLectures(request);
    }

    @ApiOperation(value = "기수강 과목 중 주 전공만 조회")
    @GetMapping("/getfirstmajorlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenFirstMajorLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenFirstMajorLectures(request);
    }

    @ApiOperation(value = "기수강 과목 중 복수 전공만 조회")
    @GetMapping("/getsecondmajorlecturetaken")
    public List<GetTakenLectureResponseDto> getTakenSecondMajorLectures(GetTakenLectureRequestDto request){
        return lectureService.getTakenSecondMajorLectures(request);
    }

    @ApiOperation(value = "선이수 과목 조회")
    @GetMapping("/getprerequisites")
    public List<GetPrerequisiteResponseDto> getPrerequisites(GetPrerequisiteRequestDto request){
        return lectureService.getPrerequisites(request);
    }

    @ApiOperation(value = "대체 가능 과목 조회")
    @GetMapping("/getsubstitutes")
    public List<GetSubstituteLectureResponseDto> getSubstitutes(GetSubstituteLectureRequestDto request){
        return lectureService.getSubstitutes(request);
    }

    @ApiOperation(value = "대체 과목 대체 대상 조회")
    @GetMapping("/getoriginallectures")
    public List<GetOriginalLecturesResponseDto> getOriginalLectures(GetOriginalLecturesRequestDto request){
        return lectureService.getOriginalLectures(request);
    }

    @ApiOperation(value = "기수강 과목 삭제")
    @DeleteMapping("/deletetakenlecture")
    public Boolean deleteTakenLecture(DeleteTakenLectureRequestDto request){
        return lectureService.deleteTakenLecture(request);
    }

}
