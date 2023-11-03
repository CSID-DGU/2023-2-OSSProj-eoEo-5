package com.eoeo.eoeoservice.domain.lecture_taken;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LectureTakenRepository extends JpaRepository<LectureTaken, Long> {
}
