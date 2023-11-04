package com.eoeo.eoeoservice.domain.core_course;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CoreCourseRepository extends JpaRepository<CoreCourse, Long>{

    Optional<CoreCourse> findByIdAndIsDeleted(Long id, Boolean isDeleted);
}
