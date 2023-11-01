package com.eoeo.eoeoservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
public class EoeoserviceApplication {

	public static void main(String[] args) {
		SpringApplication.run(EoeoserviceApplication.class, args);
	}

}
