package com.eoeo.eoeoservice.domain.substitute_lecture;

import com.eoeo.eoeoservice.domain.lecture.Lecture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SubstituteLectureRepository extends JpaRepository<SubstituteLecture, Long> {

    Optional<SubstituteLecture> findByIdAndIsDeleted(Long id, Boolean isDeleted);

    List<SubstituteLecture> findAllByOriginalLectureIdAndIsDeleted(Long originalLectureId, Boolean isDeleted);

    List<SubstituteLecture> findAllBySubstituteLectureIdAndIsDeleted(Long substituteLectureId, Boolean isDeleted);

    Optional<SubstituteLecture> findByOriginalLectureAndSubstituteLectureAndIsDeleted(Lecture originalLecture, Lecture substituteLecture, Boolean isDeleted);
}
