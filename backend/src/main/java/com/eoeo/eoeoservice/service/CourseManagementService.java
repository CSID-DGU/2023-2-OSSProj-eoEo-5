package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.core_course.CoreCourseRepository;
import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCredit;
import com.eoeo.eoeoservice.domain.core_course_credit.CoreCourseCreditRepository;
import com.eoeo.eoeoservice.domain.core_lecture_type.CoreLectureType;
import com.eoeo.eoeoservice.domain.core_lecture_type.CoreLectureTypeRepository;
import com.eoeo.eoeoservice.domain.course_lectures.CourseLectures;
import com.eoeo.eoeoservice.domain.course_lectures.CourseLecturesRepository;
import com.eoeo.eoeoservice.domain.course_type.CourseType;
import com.eoeo.eoeoservice.domain.course_type.CourseTypeRepository;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.domain.lecture.LectureRepository;
import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseCreditRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCoreCourseRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddCourseTypeRequestDto;
import com.eoeo.eoeoservice.dto.course_management.AddLectureToCourseRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class CourseManagementService {

    private final CourseTypeRepository courseTypeRepository;
    private final CoreCourseRepository coreCourseRepository;
    private final CoreLectureTypeRepository coreLectureTypeRepository;
    private final CoreCourseCreditRepository coreCourseCreditRepository;
    private final LectureRepository lectureRepository;
    private final CourseLecturesRepository courseLecturesRepository;



    @Transactional
    public Long addCourseType(AddCourseTypeRequestDto request){
        CourseType courseType = CourseType.builder()
                .name(request.getName())
                .isRequired(request.getIsRequired())
                .build();

        courseTypeRepository.save(courseType);

        return courseType.getId();

    }

    @Transactional
    public Long addCoreCourse(AddCoreCourseRequestDto request){
        CoreCourse coreCourse = CoreCourse.builder()
                .name(request.getName())
                .build();

        coreCourseRepository.save(coreCourse);

        return coreCourse.getId();
    }

    @Transactional
    public Long addCoreCourseCredit(AddCoreCourseCreditRequestDto request) {
        CoreCourse coreCourse = coreCourseRepository.findById(request.getCoreCourseId())
                .orElseThrow(() -> new NoSuchElementException("No such core course"));

        CoreLectureType coreLectureType = coreLectureTypeRepository.findById(request.getCoreLectureTypeId())
                .orElseThrow(() -> new NoSuchElementException("No such core lecture type"));

        CoreCourseCredit coreCourseCredit = CoreCourseCredit.builder()
                .coreCourse(coreCourse)
                .coreLectureType(coreLectureType)
                .credit(request.getCredit())
                .build();

        coreCourseCreditRepository.save(coreCourseCredit);

        return coreCourseCredit.getId();
    }

    @Transactional
    public Long addLectureToCourse(AddLectureToCourseRequestDto request){
        CourseType courseType = courseTypeRepository.findById(request.getCourseId())
                .orElseThrow(() -> new NoSuchElementException("No such course type"));

        Lecture lecture = lectureRepository.findById(request.getLectureId())
                .orElseThrow(() -> new NoSuchElementException("No such lecture"));

        CourseLectures courseLectures = CourseLectures.builder()
                .courseType(courseType)
                .lecture(lecture)
                .build();

        courseLecturesRepository.save(courseLectures);

        return courseLectures.getId();
    }

}
