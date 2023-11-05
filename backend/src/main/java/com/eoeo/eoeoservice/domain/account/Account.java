package com.eoeo.eoeoservice.domain.account;

import com.eoeo.eoeoservice.domain.BaseEntity;
import com.eoeo.eoeoservice.domain.lecture.Lecture;
import com.eoeo.eoeoservice.domain.major.Major;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.hibernate.annotations.SQLDelete;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.Collection;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@SQLDelete(sql = "UPDATE Account SET isDeleted = true WHERE id = ?")
public class Account extends BaseEntity implements UserDetails{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String salt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "major_id", nullable = true)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private Major major;

    @Column(nullable = false)
    private Boolean isSecondMajor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "secound_major_id", nullable = true)
    @OnDelete(action = OnDeleteAction.NO_ACTION)
    private Major secondMajor;

    private String validationToken;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public void setValidationToken(String validationToken){
        this.validationToken = validationToken;
    }

    public void setSecondMajor(Major major){
        secondMajor = major;
    }
}