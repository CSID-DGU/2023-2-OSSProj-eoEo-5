package com.eoeo.eoeoservice.domain.prerequisite;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PrerequisiteRepository extends JpaRepository<Prerequisite, Long> {

    List<Prerequisite> findAllByLectureIdAndIsDeleted(Long lectureId, Boolean isDeleted);
}
