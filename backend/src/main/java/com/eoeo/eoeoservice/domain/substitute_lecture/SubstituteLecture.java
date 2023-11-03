package com.eoeo.eoeoservice.domain.substitute_lecture;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;


@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class SubstituteLecture extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "original_lecture_id", nullable = false)
    private Lecture originalLecture;

    @ManyToOne
    @JoinColumn(name = "substitute_lecture_id", nullable = false)
    private Lecture substituteLecture;

}
