package com.eoeo.eoeoservice.security;

import com.eoeo.eoeoservice.dto.auth.RefreshTokenValidationDto;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.time.temporal.ChronoUnit;
import java.util.Date;

@Service
@RequiredArgsConstructor
public class JwtProvider {

    private final UserDetailsService userDetailsService;

    private String tokenKey = "secretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecretsecret";

    private long expireTimeAccessToken = 2L;

    private long expireRefreshToken = 14L;

    public String createAccessToken(String userPk){
        Claims claims = Jwts.claims().setSubject(userPk);
        Date now = new Date();
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(Date.from(now.toInstant().plus(expireTimeAccessToken, ChronoUnit.HOURS)))
                .signWith(SignatureAlgorithm.HS256, tokenKey)
                .compact();
    }

    /**
     * RefreshToken 생성 메소드
     * userPk는 username, validationToken은 리프레시 토큰이 유효한지 확인하는 토큰값
     */
    public String createRefreshToken(String userPk, String validationToken){
        Claims claims = Jwts.claims().setSubject(userPk);
        Date now = new Date();
        claims.put("validationToken", validationToken);
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(Date.from(now.toInstant().plus(expireRefreshToken, ChronoUnit.HOURS)))
                .signWith(SignatureAlgorithm.HS256, tokenKey)
                .compact();

    }

    public Authentication authenticate(String token) throws Exception{
        Claims claims = Jwts.parserBuilder().setSigningKey(tokenKey).build().parseClaimsJws(token).getBody();

        if(claims.getExpiration().before(new Date()) || claims.getIssuedAt().after(new Date())){
            throw new BadCredentialsException("Not a valid user");
        }

        UserDetails userDetails = userDetailsService.loadUserByUsername(claims.getSubject());

        if(!validateUserDetails(userDetails)){
            throw new BadCredentialsException("Not a valid user");
        }
        return new UsernamePasswordAuthenticationToken(userDetails, "" ,userDetails.getAuthorities());

    }

    public String getUserPk(String token){
        return Jwts.parserBuilder().setSigningKey(tokenKey).build().parseClaimsJws(token).getBody().getSubject();
    }

    public RefreshTokenValidationDto extractClaimAndUsername(String token){
        Claims claims = Jwts.parserBuilder().setSigningKey(tokenKey).build().parseClaimsJws(token).getBody();
        return RefreshTokenValidationDto.builder()
                .username(claims.getSubject())
                .claims(claims)
                .build();
    }

    public String createValidationToken(){
        int randomNumber = 0;
        while(randomNumber<100000000){
            randomNumber = (int)(Math.random()*1000000000);
        }
        return Integer.toString(randomNumber);
    }

    private boolean validateUserDetails(UserDetails userDetails){
        if(userDetails == null ||!userDetails.isEnabled() || !userDetails.isAccountNonExpired()
                || !userDetails.isAccountNonLocked() || !userDetails.isCredentialsNonExpired()){
            return false;
        } else{
            return true;
        }
    }




}
