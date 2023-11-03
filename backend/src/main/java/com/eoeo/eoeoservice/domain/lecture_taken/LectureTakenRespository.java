package com.eoeo.eoeoservice.domain.lecture_taken;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LectureTakenRespository extends JpaRepository<LectureTaken, Long> {
}
