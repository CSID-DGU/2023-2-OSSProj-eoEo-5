package com.eoeo.eoeoservice.domain.lecture;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureType;
import com.eoeo.eoeoservice.domain.course_type.CourseType;
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
public class Lecture extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String lectureNumber;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private boolean isCoreLecture;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="course_id")
    private CourseType course;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="core_lecture_type_id")
    private CoreLectureType coreLectureType;

    @Column(nullable = false)
    private Long credit;


}
