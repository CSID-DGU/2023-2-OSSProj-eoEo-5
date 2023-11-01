package com.eoeo.eoeoservice.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Server;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.Collections;

/**
 * Swagger Configuration file
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig{

    @Bean
    public Docket api(){
        Server serverOperation = new Server("operation", "https://eoeoservice.site", "Server Api Address", Collections.emptyList(), Collections.emptyList());
        Server serverLocal = new Server("operation", "http://localhost:8080", "Local Testing Address", Collections.emptyList(), Collections.emptyList());

        return new Docket(DocumentationType.OAS_30)
                .servers(serverOperation, serverLocal)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo(){
        return new ApiInfoBuilder()
                .title("Eoeo Rest Api")
                .version("1.0.0")
                .description("Eoeo service REST api documentation")
                .build();
    }

}
