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
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LectureService {

    private final AccountRepository accountRepository;
    private final LectureRepository lectureRepository;
    private final PrerequisiteRepository prerequisiteRepository;
    private final SubstituteLectureRepository substituteLectureRepository;
    private final LectureTakenRepository lectureTakenRepository;


    @Transactional
    public Long addTakenLecture(AddTakenLectureRequestDto request) {

        LectureTaken lectureTaken;

        Account account = accountRepository.findById(request.getAccountId())
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        Lecture lecture = lectureRepository.findByLectureNumberAndIsDeleted(request.getLectureNumber(), false)
                .orElseThrow(() -> new NoSuchElementException("No such Lecture"));

        Optional<LectureTaken> existedLectureTaken = lectureTakenRepository.findByAccountAndLectureAndIsDeleted(account, lecture, false);

        if (existedLectureTaken.isPresent()) {
            lectureTaken = existedLectureTaken.get();
        } else {

            if (request.getIsSubstitute()) {

                Lecture originalLecture = lectureRepository.findByLectureNumberAndIsDeleted(request.getOriginalLectureNumber(), false)
                        .orElseThrow(() -> new NoSuchElementException("No such Lecture"));

                SubstituteLecture substituteLecture = substituteLectureRepository.findByOriginalLectureAndSubstituteLectureAndIsDeleted(originalLecture, lecture, false)
                        .orElseThrow(() -> new NoSuchElementException("No such substitute"));

                lectureTaken = LectureTaken.builder()
                        .account(account)
                        .lecture(lecture)
                        .isCoreLecture(request.getIsCoreLecture())
                        .isSecondMajor(request.getIsSecondMajor())
                        .isSubstitute(true)
                        .substituteLecture(substituteLecture)
                        .build();
            } else {
                lectureTaken = LectureTaken.builder()
                        .account(account)
                        .lecture(lecture)
                        .isCoreLecture(request.getIsCoreLecture())
                        .isSecondMajor(request.getIsSecondMajor())
                        .isSubstitute(false)
                        .build();
            }

            lectureTakenRepository.save(lectureTaken);

        }

        return lectureTaken.getId();
    }

    @Transactional
    public Boolean addTakenLectures(AddTakenLecturesRequestDto requests) {
        Account account = accountRepository.findByIdAndIsDeleted(requests.getAccountId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        for (LectureTakenDto dto : requests.getLectures()) {
            Lecture lecture = lectureRepository.findByLectureNumberAndIsDeleted(dto.getLectureNumber(), false).orElseThrow(() -> new NoSuchElementException("No such lecture"));
            if (lectureTakenRepository.findByAccountAndLectureAndIsDeleted(account, lecture, false).isPresent()) {
                continue;
            }
            LectureTaken lectureTaken = LectureTaken.builder()
                    .account(account)
                    .lecture(lecture)
                    .isCoreLecture(dto.getIsCoreLecture())
                    .isSecondMajor(dto.getIsSecondMajor())
                    .isSubstitute(false)
                    .build();

            if (dto.getIsSubstitute()) {
                Lecture originalLecture = lectureRepository.findByLectureNumberAndIsDeleted(dto.getOriginalLectureNumber(), false)
                        .orElseThrow(() -> new NoSuchElementException("No such Lecture"));
                SubstituteLecture substituteLecture = substituteLectureRepository.findByOriginalLectureAndSubstituteLectureAndIsDeleted(originalLecture, lecture, false)
                                .orElseThrow(() -> new NoSuchElementException("No such substitute lecture"));
                lectureTaken.setSubstitute(substituteLecture);
            }

            lectureTakenRepository.save(lectureTaken);

        }
        return true;
    }

    public List<GetTakenLectureResponseDto> getTakenLectures(GetTakenLectureRequestDto request) {

        Account account = accountRepository.findByIdAndIsDeleted(request.getUserId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        List<LectureTaken> takenLectures = lectureTakenRepository.findAllByAccountAndIsDeleted(account, false);

        return addTakenLectureDatatoList(takenLectures);
    }

    public GetTakenLectureSortedResponseDto getTakenLecturesSorted(GetTakenLectureRequestDto request){
        Account account = accountRepository.findByIdAndIsDeleted(request.getUserId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        List<LectureTaken> takenCoreLectures = lectureTakenRepository.findAllByAccountAndIsCoreLectureAndIsSecondMajorAndIsDeleted(account, true, false, false);
        List<LectureTaken> takenFirstMajorLectures = lectureTakenRepository.findAllByAccountAndIsCoreLectureAndIsSecondMajorAndIsDeleted(account, false, false, false);
        List<LectureTaken> takenSecondMajorLectures = lectureTakenRepository.findAllByAccountAndIsCoreLectureAndIsSecondMajorAndIsDeleted(account, false, true, false);

        return GetTakenLectureSortedResponseDto.builder()
                .coreLectures(addTakenLectureDatatoList(takenCoreLectures))
                .firstMajor(addTakenLectureDatatoList(takenFirstMajorLectures))
                .secondMajor(addTakenLectureDatatoList(takenSecondMajorLectures))
                .build();

    }

    public List<GetTakenLectureResponseDto> getTakenCoreLectures(GetTakenLectureRequestDto request){
        Account account = accountRepository.findByIdAndIsDeleted(request.getUserId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        List<LectureTaken> takenLectures = lectureTakenRepository.findAllByAccountAndIsCoreLectureAndIsSecondMajorAndIsDeleted(account, true, false, false);

        return addTakenLectureDatatoList(takenLectures);
    }

    public List<GetTakenLectureResponseDto> getTakenFirstMajorLectures(GetTakenLectureRequestDto request){
        Account account = accountRepository.findByIdAndIsDeleted(request.getUserId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        List<LectureTaken> takenLectures = lectureTakenRepository.findAllByAccountAndIsCoreLectureAndIsSecondMajorAndIsDeleted(account, false, false, false);

        return addTakenLectureDatatoList(takenLectures);
    }

    public List<GetTakenLectureResponseDto> getTakenSecondMajorLectures(GetTakenLectureRequestDto request){
        Account account = accountRepository.findByIdAndIsDeleted(request.getUserId(), false)
                .orElseThrow(() -> new NoSuchElementException("No such user"));

        List<LectureTaken> takenLectures = lectureTakenRepository.findAllByAccountAndIsCoreLectureAndIsSecondMajorAndIsDeleted(account, false, true, false);

        return addTakenLectureDatatoList(takenLectures);
    }

    public List<GetPrerequisiteResponseDto> getPrerequisites(GetPrerequisiteRequestDto request) {
        List<GetPrerequisiteResponseDto> response = new LinkedList<>();

        List<Prerequisite> prerequisites = prerequisiteRepository.findAllByLectureIdAndIsDeleted(request.getLectureId(), false);

        for (Prerequisite prerequisite : prerequisites) {
            Lecture prerequisiteLecture = prerequisite.getLecture();
            response.add(GetPrerequisiteResponseDto.builder()
                    .name(prerequisiteLecture.getName())
                    .lectureNumber(prerequisiteLecture.getLectureNumber())
                    .credit(prerequisiteLecture.getCredit())
                    .build());
        }

        return response;
    }

    public List<GetSubstituteLectureResponseDto> getSubstitutes(GetSubstituteLectureRequestDto request) {
        List<GetSubstituteLectureResponseDto> response = new LinkedList<>();

        List<SubstituteLecture> substitutes = substituteLectureRepository.findAllByOriginalLectureIdAndIsDeleted(request.getLectureId(), false);

        for (SubstituteLecture substitute : substitutes) {
            Lecture substituteLecture = substitute.getSubstituteLecture();

            response.add(GetSubstituteLectureResponseDto.builder()
                    .lectureId(substituteLecture.getId())
                    .name(substituteLecture.getName())
                    .lectureNumber(substituteLecture.getLectureNumber())
                    .build());
        }

        return response;
    }

    public List<GetOriginalLecturesResponseDto> getOriginalLectures(GetOriginalLecturesRequestDto request) {

        List<GetOriginalLecturesResponseDto> response = new LinkedList<>();

        List<SubstituteLecture> substitutes = substituteLectureRepository.findAllBySubstituteLectureIdAndIsDeleted(request.getSubstituteLectureId(), false);

        for (SubstituteLecture substitute : substitutes) {

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

    private List<GetTakenLectureResponseDto> addTakenLectureDatatoList(List<LectureTaken> takenLectures){

        List<GetTakenLectureResponseDto> response = new LinkedList<>();

        for (LectureTaken takenLecture : takenLectures) {
            Lecture lecture = takenLecture.getLecture();
            GetTakenLectureResponseDto getTakenLectureResponseDto = GetTakenLectureResponseDto.builder()
                    .id(takenLecture.getId())
                    .name(lecture.getName())
                    .lectureNumber(lecture.getLectureNumber())
                    .credit(lecture.getCredit())
                    .isCoreLecture(lecture.isCoreLecture())
                    .build();

            if (lecture.isCoreLecture()) {
                getTakenLectureResponseDto.setCoreCourse(lecture);
            }

            if (takenLecture.isSubstitute()) {
                getTakenLectureResponseDto.setOriginalLecture(takenLecture.getSubstituteLecture());
            }

            response.add(getTakenLectureResponseDto);

        }

        return response;
    }
}
