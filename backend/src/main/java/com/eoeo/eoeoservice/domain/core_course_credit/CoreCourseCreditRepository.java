package com.eoeo.eoeoservice.domain.core_course_credit;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CoreCourseCreditRepository extends JpaRepository<CoreCourseCredit, Long> {

    Optional<CoreCourseCredit> findByIdAndIsDeleted(Long id, Boolean isDeleted);
}
