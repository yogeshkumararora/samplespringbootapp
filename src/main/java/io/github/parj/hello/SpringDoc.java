package io.github.parj.hello;

import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;

public class SpringDoc {
    @Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder()
                //.group("springshop-public")
                //.pathsToMatch("/public/**")
                .build();
    }
}
