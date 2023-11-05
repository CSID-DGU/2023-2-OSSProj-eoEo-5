package com.eoeo.eoeoservice.service;

import com.eoeo.eoeoservice.domain.account.Account;
import com.eoeo.eoeoservice.domain.account.AccountRepository;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.domain.lecture.LectureRepository;
import com.eoeo.eoeoservice.domain.lecture_taken.LectureTaken;
import com.eoeo.eoeoservice.domain.lecture_taken.LectureTakenRepository;
import com.eoeo.eoeoservice.domain.prerequisite.Prerequisite;
import com.eoeo.eoeoservice.domain.prerequisite.PrerequisiteRepository;
import com.eoeo.eoeoservice.domain.substitute_lecture.SubstituteLecture;
import com.eoeo.eoeoservice.domain.substitute_lecture.SubstituteLectureRepository;
import com.eoeo.eoeoservice.dto.lecture.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedList;
import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class LectureService {

    private final AccountRepository accountRepository;
    private final LectureRepository lectureRepository;
    private final PrerequisiteRepository prerequisiteRepository;
    private final SubstituteLectureRepository substituteLectureRepository;
    private final LectureTakenRepository lectureTakenRepository;



    @Transactional
    public Long addTakenLecture(AddTakenLectureRequestDto request){

        LectureTaken lectureTaken;

        Account account = accountRepository.findById(request.getAccountId())
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        Lecture lecture = lectureRepository.findById(request.getLectureId())
                .orElseThrow(() -> new NoSuchElementException("No such Lecture"));

        if(request.getIsSubstitute()){

            SubstituteLecture substituteLecture = substituteLectureRepository.findByIdAndIsDeleted(request.getSubstituteId(), false)
                    .orElseThrow(() -> new NoSuchElementException("No such prerequisite"));

            lectureTaken = LectureTaken.builder()
                    .account(account)
                    .lecture(lecture)
                    .isSubstitute(true)
                    .substituteLecture(substituteLecture)
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

    @Transactional
    public Boolean addTakenLectures(AddTakenLecturesRequestDto requests){
        Account account = accountRepository.findByIdAndIsDeleted(requests.getAccountId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        for(LectureTakenDto dto : requests.getLectures()){
            Lecture lecture = lectureRepository.findById(dto.getLectureId()).orElseThrow(() -> new NoSuchElementException("No such lecture"));
            LectureTaken lectureTaken = LectureTaken.builder()
                    .account(account)
                    .lecture(lecture)
                    .isSubstitute(false)
                    .build();

            if(dto.getIsSubstitute()){
                SubstituteLecture substituteLecture = substituteLectureRepository .findByIdAndIsDeleted(dto.getSubstituteId(), false)
                                .orElseThrow(() -> new NoSuchElementException("No such substitute lecture"));
                lectureTaken.setSubstitute(substituteLecture);
            }

            lectureTakenRepository.save(lectureTaken);

        }
        return true;
    }

    public List<GetTakenLectureResponseDto> getTakenLectures(GetTakenLectureRequestDto request){

        Account account = accountRepository.findByIdAndIsDeleted(request.getUserId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        List<GetTakenLectureResponseDto> response = new LinkedList<>();

        List<LectureTaken> takenLectures = lectureTakenRepository.findAllByAccountAndIsDeleted(account, false);

        for(LectureTaken takenLecture : takenLectures){
            Lecture lecture = takenLecture.getLecture();
            GetTakenLectureResponseDto getTakenLectureResponseDto = GetTakenLectureResponseDto.builder()
                    .id(takenLecture.getId())
                    .name(lecture.getName())
                    .lectureNumber(lecture.getLectureNumber())
                    .credit(lecture.getCredit())
                    .build();

            if(lecture.isCoreLecture()){
                getTakenLectureResponseDto.setCoreCourse(lecture);
            } else{
                getTakenLectureResponseDto.setCourseId(lecture);
            }

            if(takenLecture.isSubstitute()){
                getTakenLectureResponseDto.setOriginalLecture(takenLecture.getSubstituteLecture());
            }

            response.add(getTakenLectureResponseDto);

        }

        return response;
    }

    public List<GetPrerequisiteResponseDto> getPrerequisites(GetPrerequisiteRequestDto request){
        List<GetPrerequisiteResponseDto> response = new LinkedList<>();

        List<Prerequisite> prerequisites = prerequisiteRepository.findAllByLectureIdAndIsDeleted(request.getLectureId(), false);

        for(Prerequisite prerequisite : prerequisites){
            Lecture prerequisiteLecture = prerequisite.getLecture();
            response.add(GetPrerequisiteResponseDto.builder()
                    .name(prerequisiteLecture.getName())
                    .lectureNumber(prerequisiteLecture.getLectureNumber())
                    .credit(prerequisiteLecture.getCredit())
                    .build());
        }

        return response;
    }

    public List<GetSubstituteLectureResponseDto> getSubstitutes(GetSubstituteLectureRequestDto request){
        List<GetSubstituteLectureResponseDto> response = new LinkedList<>();

        List<SubstituteLecture> substitutes = substituteLectureRepository.findAllByOriginalLectureIdAndIsDeleted(request.getLectureId(), false);

        for(SubstituteLecture substitute: substitutes){
            Lecture substituteLecture = substitute.getSubstituteLecture();

            response.add(GetSubstituteLectureResponseDto.builder()
                    .lectureId(substituteLecture.getId())
                    .name(substituteLecture.getName())
                    .lectureNumber(substituteLecture.getLectureNumber())
                    .courseTypeId(substituteLecture.getCourseType().getId())
                    .build());
        }

        return response;
    }

    public List<GetOriginalLecturesResponseDto> getOriginalLectures(GetOriginalLecturesRequestDto request){

        List<GetOriginalLecturesResponseDto> response = new LinkedList<>();

        List<SubstituteLecture> substitutes = substituteLectureRepository.findAllBySubstituteLectureIdAndIsDeleted(request.getSubstituteLectureId(), false);

        for(SubstituteLecture substitute : substitutes){

            Lecture originalLecture = substitute.getOriginalLecture();

            response.add(GetOriginalLecturesResponseDto.builder()
                    .substituteId(substitute.getId())
                    .originalLectureId(originalLecture.getId())
                    .originalLectureName(originalLecture.getName())
                    .originalLectureNumber(originalLecture.getLectureNumber())
                    .originalLectureCredit(originalLecture.getCredit())
                    .build());

        }

        return response;

    }
}
