package com.eoeo.eoeoservice.domain.school;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SchoolRepository extends JpaRepository<School, Long> {

    Optional<School> findByIdAndIsDeleted(Long id, Boolean isDeleted);
}
