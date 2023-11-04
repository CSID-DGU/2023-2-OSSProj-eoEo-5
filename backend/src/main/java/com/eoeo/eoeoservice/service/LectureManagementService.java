package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.core_lecture_type.CoreLectureType;
import com.eoeo.eoeoservice.domain.core_lecture_type.CoreLectureTypeRepository;
import com.eoeo.eoeoservice.domain.course_type.CourseType;
import com.eoeo.eoeoservice.domain.course_type.CourseTypeRepository;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.domain.lecture.LectureRepository;
import com.eoeo.eoeoservice.domain.prerequisite.Prerequisite;
import com.eoeo.eoeoservice.domain.prerequisite.PrerequisiteRepository;
import com.eoeo.eoeoservice.domain.substitute_lecture.SubstituteLecture;
import com.eoeo.eoeoservice.domain.substitute_lecture.SubstituteLectureRepository;
import com.eoeo.eoeoservice.dto.lecture_management.AddLectureRequestDto;
import com.eoeo.eoeoservice.dto.lecture_management.SetPrerequisiteRequestDto;
import com.eoeo.eoeoservice.dto.lecture_management.SetSubstituteLectureRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class LectureManagementService {

    private final LectureRepository lectureRepository;
    private final CourseTypeRepository courseTypeRepository;
    private final CoreLectureTypeRepository coreLectureTypeRepository;
    private final PrerequisiteRepository prerequisiteRepository;
    private final SubstituteLectureRepository substituteLectureRepository;


    @Transactional
    public Long addLecture(AddLectureRequestDto request) {

        Lecture lecture;

        if(request.isCoreLecture()){
            CoreLectureType coreLectureType = coreLectureTypeRepository.findById(request.getCoreLectureTypeId())
                    .orElseThrow(() ->  new NoSuchElementException("No such core lecture type"));

            lecture = Lecture.builder()
                    .name(request.getName())
                    .lectureNumber(request.getLectureNumber())
                    .isCoreLecture(true)
                    .coreLectureType(coreLectureType)
                    .credit(request.getCredit())
                    .build();
        } else{
            CourseType courseType = courseTypeRepository.findById(request.getCourseId())
                    .orElseThrow(() -> new NoSuchElementException("No such course"));

            lecture = Lecture.builder()
                    .name(request.getName())
                    .lectureNumber(request.getLectureNumber())
                    .isCoreLecture(false)
                    .courseType(courseType)
                    .credit(request.getCredit())
                    .build();
        }

        lectureRepository.save(lecture);
        return lecture.getId();
    }

    @Transactional
    public Long setPrerequisite(SetPrerequisiteRequestDto request){
        Lecture lecture = lectureRepository.findById(request.getLectureId())
                .orElseThrow(() -> new NoSuchElementException("No such lecture"));

        Lecture prerequisiteLecture = lectureRepository.findById(request.getPrerequisiteId())
                .orElseThrow(() -> new NoSuchElementException("No such lecture"));

        Prerequisite prerequisite = Prerequisite.builder()
                .lecture(lecture)
                .prerequisite(prerequisiteLecture)
                .build();

        prerequisiteRepository.save(prerequisite);
        return prerequisite.getId();
    }

    @Transactional
    public Long setSubstituteLecture(SetSubstituteLectureRequestDto request) {
        Lecture lecture = lectureRepository.findById(request.getOriginalLectureId())
                .orElseThrow(() -> new NoSuchElementException("No such lecture"));
        Lecture substituteLecture = lectureRepository.findById(request.getSubstituteLectureId())
                .orElseThrow(() -> new NoSuchElementException("No such lecture"));

        SubstituteLecture substitute = SubstituteLecture.builder()
                .originalLecture(lecture)
                .substituteLecture(substituteLecture)
                .build();

        substituteLectureRepository.save(substitute);
        return substitute.getId();
    }

}
