package com.eoeo.eoeoservice.domain.lecture_taken;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.account.Account;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.domain.prerequisite.Prerequisite;
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
@SQLDelete(sql = "UPDATE LectureTaken SET isDeleted = true WHERE id = ?")
public class LectureTaken extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "account_id", nullable = false)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private Account account;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lecture_id", nullable = false)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private Lecture lecture;

    @Column(nullable = false)
    private boolean isSubstitute;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prerequisite_id")
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private Prerequisite prerequisite;

}
