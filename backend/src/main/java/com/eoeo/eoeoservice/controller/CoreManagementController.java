package com.eoeo.eoeoservice.controller;

import com.eoeo.eoeoservice.dto.core_management.AddCoreLectureTypeRequestDto;
import com.eoeo.eoeoservice.dto.core_management.AddMajorRequestDto;
import com.eoeo.eoeoservice.dto.core_management.AddSchoolRequestDto;
import com.eoeo.eoeoservice.service.CoreManagementService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/management/core")
@RequiredArgsConstructor
public class CoreManagementController {

    private final CoreManagementService coreManagementService;

    @PostMapping("/addschool")
    public Long addSchool(AddSchoolRequestDto request){
        System.out.println(request.getName());
        return coreManagementService.addSchool(request);
    }

    @PostMapping("/addcorelecturetype")
    public Long addCoreLectureType(AddCoreLectureTypeRequestDto request){
        return coreManagementService.addCoreLectureType(request);
    }

    @PostMapping("/addmajor")
    public Long addMajor(AddMajorRequestDto request){
        return coreManagementService.addMajor(request);
    }

}
