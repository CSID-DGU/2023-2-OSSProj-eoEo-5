package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.account.Account;
import com.eoeo.eoeoservice.domain.account.AccountRepository;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.domain.lecture.LectureRepository;
import com.eoeo.eoeoservice.domain.lecture_taken.LectureTaken;
import com.eoeo.eoeoservice.domain.lecture_taken.LectureTakenRepository;
import com.eoeo.eoeoservice.domain.prerequisite.Prerequisite;
import com.eoeo.eoeoservice.domain.prerequisite.PrerequisiteRepository;
import com.eoeo.eoeoservice.dto.lecture.AddTakenLectureRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class LectureService {

    private final AccountRepository accountRepository;
    private final LectureRepository lectureRepository;
    private final PrerequisiteRepository prerequisiteRepository;
    private final LectureTakenRepository lectureTakenRepository;



    @Transactional
    public Long addTakenLecture(AddTakenLectureRequestDto request){

        LectureTaken lectureTaken;

        Account account = accountRepository.findById(request.getAccountId())
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        Lecture lecture = lectureRepository.findById(request.getLectureId())
                .orElseThrow(() -> new NoSuchElementException("No such Lecture"));

        if(request.isSubstitute()){

            Prerequisite prerequisite = prerequisiteRepository.findById(request.getPrerequisiteId())
                    .orElseThrow(() -> new NoSuchElementException("No such prerequisite"));

            lectureTaken = LectureTaken.builder()
                    .account(account)
                    .lecture(lecture)
                    .isSubstitute(true)
                    .prerequisite(prerequisite)
                    .build();
        } else{
            lectureTaken = LectureTaken.builder()
                    .account(account)
                    .lecture(lecture)
                    .isSubstitute(false)
                    .build();
        }

        lectureTakenRepository.save(lectureTaken);

        return lectureTaken.getId();
    }
}
