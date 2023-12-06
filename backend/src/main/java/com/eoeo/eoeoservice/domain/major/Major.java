package com.eoeo.eoeoservice.domain.major;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.course_type.CourseType;
import com.eoeo.eoeoservice.domain.school.School;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.hibernate.annotations.SQLDelete;

import javax.persistence.*;


@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@SQLDelete(sql = "UPDATE major SET is_deleted = true WHERE id = ?")
public class Major extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "school_id", nullable = false)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private School school;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "core_course_id")
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private CoreCourse coreCourse;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "required_course_id", nullable = false)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private CourseType requiredCourse;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "selective_course_id", nullable = false)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private CourseType selectiveCourse;

    @Column(nullable = false)
    private Long selectiveCourseCredit;

}
