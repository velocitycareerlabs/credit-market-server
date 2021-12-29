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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.organisation.office.domain.OfficeRepositoryWrapper;
import org.apache.fineract.organisation.staff.domain.Staff;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.useradministration.domain.AppUser;
import org.apache.fineract.useradministration.domain.AppUserRepository;
import org.apache.fineract.useradministration.domain.Permission;
import org.apache.fineract.useradministration.domain.Role;
import org.apache.fineract.useradministration.domain.RoleRepository;
import org.apache.fineract.useradministration.domain.UserDomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Service;

@Service
public class Auth0UserImportService {

    public static final Integer RANDOM_PWD_CHARACTERS = 16;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserDomainService userDomainService;

    @Autowired
    private OfficeRepositoryWrapper officeRepositoryWrapper;

    @Autowired
    private AppUserRepository appUserRepository;

    @Value("${auth0.audience}")
    private String audience;

    @Value("${auth0.domain}")
    private String domain;

    public AppUser importPrincipal(Jwt jwt) {
        // NOTE: it's good practice to not include PII relevant data (email, names etc.)
        String username = jwt.getSubject();
        String password = new RandomPasswordGenerator(RANDOM_PWD_CHARACTERS).generate();
        String email = jwt.getSubject() + "@" + domain;
        String firstname = jwt.getSubject();
        String lastname = jwt.getSubject();

        Long officeId = 1l; // TODO: make this configurable
        final Office userOffice = officeRepositoryWrapper.findOneWithNotFoundDetection(officeId);
        Staff linkedStaff = null;
        boolean isSelfServiceUser = false;
        boolean passwordNeverExpire = false;

        final Set<GrantedAuthority> authorities = new HashSet<>();

        authorities.addAll(Arrays.asList(jwt.getClaimAsString("scope").split(" ")).stream().map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList()));

        Set<Role> fineractRoles = resolveRolesFromAuthorities(authorities);

        if (CollectionUtils.isEmpty(fineractRoles)) {
            throw new RuntimeException("Auth0 user has no fineract-recognisable role, please check this to login again");
        }

        final Collection<Client> clients = Collections.emptyList();

        User user = new User(username, password, authorities);
        AppUser appUser = new AppUser(userOffice, user, fineractRoles, email, firstname, lastname, linkedStaff, passwordNeverExpire,
                isSelfServiceUser, clients);

        userDomainService.create(appUser, isSelfServiceUser);

        return appUser;
    }

    public AppUser importPrincipal(OidcUser oidcUser) {
        String username = oidcUser.getName();
        String password = new RandomPasswordGenerator(RANDOM_PWD_CHARACTERS).generate();
        String email = oidcUser.getEmail();
        String firstname = oidcUser.getGivenName();
        String lastname = oidcUser.getFamilyName();

        if (StringUtils.isEmpty(firstname)) {
            firstname = oidcUser.getName();
        }
        if (StringUtils.isEmpty(lastname)) {
            lastname = oidcUser.getName();
        }

        // validate mandatory
        // validateManadatories(email, firstname, lastname);

        Long officeId = 1l; // TODO: make this configurable
        final Office userOffice = officeRepositoryWrapper.findOneWithNotFoundDetection(officeId);
        Staff linkedStaff = null;
        boolean isSelfServiceUser = false;
        boolean passwordNeverExpire = false;

        final Set<GrantedAuthority> authorities = new HashSet<>();

        authorities.addAll(oidcUser.getAuthorities());

        if (oidcUser.getAttribute(audience + "roles") != null) {
            net.minidev.json.JSONArray roles = oidcUser.getAttribute(audience + "roles");

            if (roles != null && !roles.isEmpty()) {
                authorities.addAll(roles.stream().map(Objects::toString).map(SimpleGrantedAuthority::new).collect(Collectors.toList()));
            }
        }

        Set<Role> fineractRoles = resolveRolesFromAuthorities(authorities);

        if (CollectionUtils.isEmpty(fineractRoles)) {
            throw new RuntimeException("Auth0 user has no fineract-recognisable role, please check this to login again");
        }

        final Collection<Client> clients = Collections.emptyList();

        User user = new User(username, password, authorities);
        AppUser appUser = new AppUser(userOffice, user, fineractRoles, email, firstname, lastname, linkedStaff, passwordNeverExpire,
                isSelfServiceUser, clients);

        userDomainService.create(appUser, isSelfServiceUser);

        return appUser;
    }

    public Pair<Collection<GrantedAuthority>, Set<String>> resolveAuthoritiesFromUserDetails(UserDetails userDetails) {
        final Collection<GrantedAuthority> authorities = new ArrayList<>();
        final Set<String> permissionNames = new HashSet<>();
        for (final Role role : ((AppUser) userDetails).getRoles()) {
            for (Permission permission : role.getPermissions()) {
                authorities.add(new SimpleGrantedAuthority(permission.getCode()));
                permissionNames.add(permission.getCode());
            }
        }
        return Pair.of(authorities, permissionNames);
    }

    private Set<Role> resolveRolesFromAuthorities(Collection<? extends GrantedAuthority> role) {
        return role.stream().map(ga -> roleRepository.getRoleByName(ga.getAuthority())).filter(Objects::nonNull)
                .collect(Collectors.toSet());
    }
}
