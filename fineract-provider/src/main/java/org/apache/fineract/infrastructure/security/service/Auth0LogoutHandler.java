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
package org.apache.fineract.infrastructure.security.service;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.util.UriComponentsBuilder;

@Controller
public class Auth0LogoutHandler extends SecurityContextLogoutHandler {

    private final ClientRegistrationRepository clientRegistrationRepository;

    /**
     * Create a new instance with a {@code ClientRegistrationRepository}, so that we can look up information about the
     * configured provider to call the Auth0 logout endpoint. Called by the Spring framework.
     *
     * @param clientRegistrationRepository
     *            the {@code ClientRegistrationRepository} for this application.
     */
    @Autowired
    public Auth0LogoutHandler(ClientRegistrationRepository clientRegistrationRepository) {
        this.clientRegistrationRepository = clientRegistrationRepository;
    }

    /**
     * Delegates to {@linkplain SecurityContextLogoutHandler} to log the user out of the application, and then logs the
     * user out of Auth0.
     *
     * @param httpServletRequest
     *            the request.
     * @param httpServletResponse
     *            the response.
     * @param authentication
     *            the current authentication.
     */
    @Override
    public void logout(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) {

        // Invalidate the session and clear the security context
        super.logout(httpServletRequest, httpServletResponse, authentication);

        // Build the URL to log the user out of Auth0 and redirect them to the home page.
        // URL will look like https://YOUR-DOMAIN/v2/logout?clientId=YOUR-CLIENT-ID&returnTo=http://localhost:3000
        String issuer = (String) getClientRegistration().getProviderDetails().getConfigurationMetadata().get("issuer");
        String clientId = getClientRegistration().getClientId();
        String returnTo = ServletUriComponentsBuilder.fromCurrentContextPath().build().toString();

        String logoutUrl = UriComponentsBuilder.fromHttpUrl(issuer + "v2/logout?client_id={clientId}&returnTo={returnTo}").encode()
                .buildAndExpand(clientId, returnTo).toUriString();

        try {
            httpServletResponse.sendRedirect(logoutUrl);
        } catch (IOException ioe) {
            // Handle or log error redirecting to logout URL
        }
    }

    /**
     * Gets the Spring ClientRegistration, which we use to get the registered client ID and issuer for building the
     * {@code returnTo} query parameter when calling the Auth0 logout API.
     *
     * @return the {@code ClientRegistration} for this application.
     */
    private ClientRegistration getClientRegistration() {
        return this.clientRegistrationRepository.findByRegistrationId("auth0");
    }
}
