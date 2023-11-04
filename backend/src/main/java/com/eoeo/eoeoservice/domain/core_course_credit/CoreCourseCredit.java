package com.eoeo.eoeoservice.domain.core_course_credit;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.core_course.CoreCourse;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureType;
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
@SQLDelete(sql = "UPDATE CoreCourseCredit SET isDeleted = true WHERE id = ?")
public class CoreCourseCredit extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "core_course_id", nullable = false)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private CoreCourse coreCourse;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "core_lecture_type", nullable = false)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private CoreLectureType coreLectureType;

    @Column(nullable = false)
    private Long credit;

}
