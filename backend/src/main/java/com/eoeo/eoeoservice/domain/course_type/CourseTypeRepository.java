package com.eoeo.eoeoservice.domain.course_type;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CourseTypeRepository extends JpaRepository<CourseType, Long> {

    Optional<CourseType> findByIdAndIsDeleted(Long id, Boolean isDeleted);
}
