package com.eoeo.eoeoservice.domain.core_course_credit;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CoreCourseCreditRepository extends JpaRepository<CoreCourseCredit, Long> {
}
