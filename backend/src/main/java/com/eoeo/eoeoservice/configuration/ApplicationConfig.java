package com.eoeo.eoeoservice.configuration;

import com.eoeo.eoeoservice.domain.account.AccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Configuration
@RequiredArgsConstructor
public class ApplicationConfig {

    private final AccountRepository accountRepository;

    @Bean
    public UserDetailsService userDetailsService(){
        return username -> accountRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("No such user"));
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception{
        return config.getAuthenticationManager();
    }
}
