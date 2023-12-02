package com.eoeo.eoeoservice.domain.faq;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FaqRepository extends JpaRepository<Faq, Long> {

    Optional<Faq> findByIdAndIsDeleted(Long id, Boolean isDeleted);

    List<Faq> findAllByIsDeleted(Boolean isDeleted);

    List<Faq> findAllByCategoryAndIsDeleted(String category, Boolean isDeleted);

}
