package com.eoeo.eoeoservice.domain.account;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<Account, Long> {

    Optional<Account> findByIdAndIsDeleted(Long id, Boolean isDeleted);

    Optional<Account> findByUsernameAndIsDeleted(String username, Boolean isDeleted);

}
