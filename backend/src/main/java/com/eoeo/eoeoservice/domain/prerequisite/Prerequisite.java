package com.eoeo.eoeoservice.domain.prerequisite;

import com.eoeo.eoeoservice.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class Prerequisite extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

}
