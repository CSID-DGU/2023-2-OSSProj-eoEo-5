package com.eoeo.eoeoservice.domain.core_course_type;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CoreCourseTypeRepository extends JpaRepository<CoreCourseType, Long> {
}
