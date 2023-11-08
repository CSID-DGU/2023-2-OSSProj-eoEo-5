package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCredit;
import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCreditRepository;
import com.eoeo.eoeoservice.domain.course_lectures.CourseLectures;
import com.eoeo.eoeoservice.domain.course_lectures.CourseLecturesRepository;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.dto.course.CoreCourseCreditRequestDto;
import com.eoeo.eoeoservice.dto.course.CoreCourseCreditResponseDto;
import com.eoeo.eoeoservice.dto.course.CourseLectureListRequestDto;
import com.eoeo.eoeoservice.dto.course.CourseLectureListResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CourseService {

    private final CourseLecturesRepository courseLecturesRepository;
    private final CoreCourseCreditRepository coreCourseCreditRepository;

    public List<CourseLectureListResponseDto> getCourseLectures(CourseLectureListRequestDto request){

        List<CourseLectureListResponseDto> response = new LinkedList<>();

        List<CourseLectures> lectureList = courseLecturesRepository.findAllByCourseTypeIdAndIsDeleted(request.getCourseId(), false);

        for(CourseLectures courseLectures : lectureList){
            Lecture lecture = courseLectures.getLecture();

            response.add(CourseLectureListResponseDto.builder()
                    .lectureId(lecture.getId())
                    .lectureName(lecture.getName())
                    .lectureNumber(lecture.getLectureNumber())
                    .credit(lecture.getCredit())
                    .build());

        }

        return response;

    }

    public List<CoreCourseCreditResponseDto> getCoreCourseCredits(CoreCourseCreditRequestDto request){
        List<CoreCourseCreditResponseDto> response = new LinkedList<>();

        List<CoreCourseCredit> coreCourseCreditList = coreCourseCreditRepository.findAllByCoreCourseIdAndIsDeleted(request.getCoreCourseId(), false);

        for(CoreCourseCredit coreCourseCredit : coreCourseCreditList){
            response.add(CoreCourseCreditResponseDto.builder()
                    .coreLectureTypeId(coreCourseCredit.getCoreLectureType().getId())
                    .coreLectureTypeName(coreCourseCredit.getCoreLectureType().getName())
                    .coreLectureCredit(coreCourseCredit.getCredit())
                    .build());
        }

        return response;
    }
}
