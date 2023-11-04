package com.eoeo.eoeoservice.domain.lecture;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.core_course_type.CoreLectureType;
import com.eoeo.eoeoservice.domain.course_type.CourseType;
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
@SQLDelete(sql = "UPDATE Lecture SET isDeleted = true WHERE id = ?")
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
    @JoinColumn(name="course_type_id")
    private CourseType courseType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="core_lecture_type_id")
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private CoreLectureType coreLectureType;

    @Column(nullable = false)
    private Long credit;


}
