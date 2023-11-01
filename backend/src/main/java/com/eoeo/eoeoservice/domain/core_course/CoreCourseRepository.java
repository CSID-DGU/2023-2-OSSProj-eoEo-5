package com.eoeo.eoeoservice.domain.core_course;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CoreCourseRepository extends JpaRepository<CoreCourse, Long>{

}
