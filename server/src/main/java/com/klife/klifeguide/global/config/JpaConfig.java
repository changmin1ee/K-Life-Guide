package com.klife.klifeguide.global.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaAuditing
@EnableJpaRepositories(basePackages = {
        "com.klife.klifeguide.domain.member.repository",
        "com.klife.klifeguide.domain.mission.repository",
        "com.klife.klifeguide.domain.phrase.repository",
        "com.klife.klifeguide.domain.reward.repository",
        "com.klife.klifeguide.domain.roadmap.repository"
})
public class JpaConfig {
}
