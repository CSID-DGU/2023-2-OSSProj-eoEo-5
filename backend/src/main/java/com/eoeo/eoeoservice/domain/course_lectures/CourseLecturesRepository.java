package com.eoeo.eoeoservice.domain.course_lectures;

import com.eoeo.eoeoservice.domain.course_type.CourseType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseLecturesRepository extends JpaRepository<CourseLectures, Long> {

    Optional<CourseLectures> findByIdAndIsDeleted(Long id, Boolean isDeleted);

    List<CourseLectures> findAllByCourseTypeIdAndIsDeleted(Long courseTypeId, Boolean isDeleted);

    List<CourseLectures> findAllByCourseTypeAndIsDeleted(CourseType courseType, Boolean isDeleted);
}
