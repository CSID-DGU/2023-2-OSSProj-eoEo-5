package com.eoeo.eoeoservice.domain.substitute_lecture;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubstituteLectureRepository extends JpaRepository<SubstituteLecture, Long> {
}
