package com.eoeo.eoeoservice.domain.core_course_type;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CoreLectureTypeRepository extends JpaRepository<CoreLectureType, Long> {

    Optional<CoreLectureType> findByIdAndIsDeleted(Long id, Boolean isDeleted);
}
