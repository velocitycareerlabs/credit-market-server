/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.fineract.infrastructure.core.boot;

import com.sun.jersey.spi.spring.container.servlet.SpringServlet;
import org.apache.fineract.infrastructure.security.filter.TenantAwareAuth0Filter;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Profile("auth0")
@Configuration
@EnableWebSecurity(debug = true)
@EnableGlobalMethodSecurity(jsr250Enabled = true)
@Order(SecurityProperties.BASIC_AUTH_ORDER)
public class WebXmlAuth0Configuration extends WebSecurityConfigurerAdapter {

    @Bean
    public ServletRegistrationBean jersey() {
        ServletRegistrationBean<SpringServlet> jerseyServletRegistration = new ServletRegistrationBean<>();
        jerseyServletRegistration.setServlet(new SpringServlet());
        jerseyServletRegistration.addUrlMappings("/api/v1/*");
        jerseyServletRegistration.setName("jersey-servlet");
        jerseyServletRegistration.setLoadOnStartup(1);
        jerseyServletRegistration.addInitParameter("com.sun.jersey.api.json.POJOMappingFeature", "true");
        jerseyServletRegistration.addInitParameter("com.sun.jersey.config.feature.DisableWADL", "true");
        return jerseyServletRegistration;
    }

    @Bean
    @Primary
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {

            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**").allowedOrigins("*");
            }
        };
    }

    @Bean
    public FilterRegistrationBean<TenantAwareAuth0Filter> tenantAwareAuth0FilterBean(TenantAwareAuth0Filter filter) {
        FilterRegistrationBean<TenantAwareAuth0Filter> registrationBean = new FilterRegistrationBean<>(filter);
        registrationBean.addUrlPatterns("/api/*");
        registrationBean.setEnabled(true);
        return registrationBean;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().and().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
                .httpBasic(AbstractHttpConfigurer::disable).csrf(AbstractHttpConfigurer::disable).authorizeRequests()
                .antMatchers(HttpMethod.OPTIONS).permitAll().antMatchers("/api/**").authenticated().and().oauth2ResourceServer()
                .jwt(Customizer.withDefaults());
    }
}
