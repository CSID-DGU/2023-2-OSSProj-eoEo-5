package com.eoeo.eoeoservice.domain.core_course_credit;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureType;
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
public class CoreCourseCredit extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "core_course_id")
    private CoreCourse coreCourse;

    @ManyToOne
    @JoinColumn(name = "core_lecture_type")
    private CoreLectureType coreLectureType;

    @Column(nullable = false)
    private Long credit;

}
