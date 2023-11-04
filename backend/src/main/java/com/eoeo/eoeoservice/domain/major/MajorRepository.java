package com.eoeo.eoeoservice.domain.major;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MajorRepository extends JpaRepository<Major, Long> {

    List<Major> findAllByIdAndIsDeleted(Long id, Boolean isDeleted);

    Optional<Major> findByIdAndIsDeleted(Long id, Boolean isDeleted);
}
