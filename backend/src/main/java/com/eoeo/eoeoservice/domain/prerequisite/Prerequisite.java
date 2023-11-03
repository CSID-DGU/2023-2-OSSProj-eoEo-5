package com.eoeo.eoeoservice.domain.prerequisite;

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
public class Prerequisite extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="lecture_id", nullable = false)
    private Lecture lecture;

    @ManyToOne
    @JoinColumn(name="prerequisite_id", nullable = false)
    private Lecture prerequisite;

}
