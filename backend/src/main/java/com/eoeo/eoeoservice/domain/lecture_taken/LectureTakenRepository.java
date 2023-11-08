package com.eoeo.eoeoservice.domain.lecture_taken;

import com.eoeo.eoeoservice.domain.account.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LectureTakenRepository extends JpaRepository<LectureTaken, Long> {

    List<LectureTaken> findAllByAccountAndIsDeleted(Account account, Boolean isDeleted);
}
