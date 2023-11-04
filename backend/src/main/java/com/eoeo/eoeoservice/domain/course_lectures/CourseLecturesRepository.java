package com.eoeo.eoeoservice.domain.course_lectures;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseLecturesRepository extends JpaRepository<CourseLectures, Long> {


}
