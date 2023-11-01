package com.eoeo.eoeoservice.domain.major;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.course.Course;
import com.eoeo.eoeoservice.domain.school.School;
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
public class Major extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @ManyToOne
    @JoinColumn(name = "school_id")
    private School school;

    @ManyToOne
    @JoinColumn(name = "core_course_id")
    private CoreCourse coreCourse;

    @ManyToOne
    @JoinColumn(name = "required_course_id")
    private Course requiredCourse;

    @ManyToOne
    @JoinColumn(name = "selective_course_id")
    private Course selectiveCourse;

    @Column(nullable = false)
    private Long selectiveCourseCredit;

}