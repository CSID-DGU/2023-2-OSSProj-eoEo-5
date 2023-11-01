package com.eoeo.eoeoservice.domain.class_taken;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClassTakenRespository extends JpaRepository<ClassTaken, Long> {
}
