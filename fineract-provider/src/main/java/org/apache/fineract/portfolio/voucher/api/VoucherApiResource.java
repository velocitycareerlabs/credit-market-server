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
package org.apache.fineract.portfolio.voucher.api;

import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.Date;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriInfo;
import org.apache.fineract.accounting.journalentry.api.DateParam;
import org.apache.fineract.commands.domain.CommandWrapper;
import org.apache.fineract.commands.service.CommandWrapperBuilder;
import org.apache.fineract.commands.service.PortfolioCommandSourceWritePlatformService;
import org.apache.fineract.infrastructure.core.api.ApiRequestParameterHelper;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.serialization.ApiRequestJsonSerializationSettings;
import org.apache.fineract.infrastructure.core.serialization.DefaultToApiJsonSerializer;
import org.apache.fineract.infrastructure.core.service.Page;
import org.apache.fineract.infrastructure.core.service.SearchParameters;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.voucher.data.VoucherBalanceDTO;
import org.apache.fineract.portfolio.voucher.data.VoucherDTO;
import org.apache.fineract.portfolio.voucher.data.VoucherTransactionDTO;
import org.apache.fineract.portfolio.voucher.service.VoucherReadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Path("/vouchers/{clientId}")
@Component
@Scope("singleton")
@Tag(name = "Vouchers", description = "This is used to both load and update vouchers")
public class VoucherApiResource {

    private final PlatformSecurityContext context;
    private final VoucherReadService voucherReadService;
    private final String resourceNameForPermissions = "VOUCHER";
    private final PortfolioCommandSourceWritePlatformService commandsSourceWritePlatformService;
    private final DefaultToApiJsonSerializer<VoucherTransactionDTO> toApiJsonSerializer;
    private final ApiRequestParameterHelper apiRequestParameterHelper;

    @Autowired
    public VoucherApiResource(final PlatformSecurityContext context, final VoucherReadService voucherReadService,
            final PortfolioCommandSourceWritePlatformService commandsSourceWritePlatformService,
            final DefaultToApiJsonSerializer<VoucherTransactionDTO> toApiJsonSerializer,
            final ApiRequestParameterHelper apiRequestParameterHelper) {
        this.context = context;
        this.voucherReadService = voucherReadService;
        this.commandsSourceWritePlatformService = commandsSourceWritePlatformService;
        this.toApiJsonSerializer = toApiJsonSerializer;
        this.apiRequestParameterHelper = apiRequestParameterHelper;
    }

    @GET
    @Path("balance")
    @Consumes({ MediaType.APPLICATION_JSON })
    @Produces({ MediaType.APPLICATION_JSON })
    public VoucherBalanceDTO getVouchersByClientId(@PathParam("clientId") @Parameter(description = "clientId") final Long clientId) {
        this.context.authenticatedUser().validateHasReadPermission(this.resourceNameForPermissions);
        return this.voucherReadService.retrieveBalance(clientId);
    }

    @GET
    @Path("expiring/{days}")
    @Consumes({ MediaType.APPLICATION_JSON })
    @Produces({ MediaType.APPLICATION_JSON })
    public List<VoucherDTO> getVouchersByClientId(@PathParam("clientId") @Parameter(description = "clientId") final Long clientId,
            @PathParam("days") @Parameter(description = "days") final Integer days) {
        this.context.authenticatedUser().validateHasReadPermission(this.resourceNameForPermissions);
        return this.voucherReadService.retrieveExpiringInDays(clientId, days);
    }

    @POST
    @Consumes({ MediaType.APPLICATION_JSON })
    @Produces({ MediaType.APPLICATION_JSON })
    public String useVoucher(@PathParam("clientId") @Parameter(description = "clientId") final Long clientId,
            final String apiRequestBodyAsJson) {
        final CommandWrapper commandRequest = new CommandWrapperBuilder().createVoucherTransaction(clientId).withJson(apiRequestBodyAsJson)
                .build();
        CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return this.toApiJsonSerializer.serialize(result);
    }

    @GET
    @Consumes({ MediaType.APPLICATION_JSON })
    @Produces({ MediaType.APPLICATION_JSON })
    public String retrieveAllVoucherTransactions(@Context final UriInfo uriInfo, @PathParam("clientId") final Long clientId,
            @QueryParam("pageNumber") final Integer pageNumber, @QueryParam("pageSize") final Integer pageSize,
            @QueryParam("fromDate") @Parameter(description = "fromDate") final DateParam fromDateParam,
            @QueryParam("toDate") @Parameter(description = "toDate") final DateParam toDateParam,
            @QueryParam("dateFormat") @Parameter(description = "dateFormat") final String dateFormat,
            @QueryParam("locale") @Parameter(description = "locale") final String locale) {

        this.context.authenticatedUser().validateHasReadPermission(this.resourceNameForPermissions);
        SearchParameters searchParameters = pageNumber != null && pageSize != null ? SearchParameters.forPagination(pageNumber, pageSize)
                : null;

        Date fromDate = null;
        if (fromDateParam != null) {
            fromDate = fromDateParam.getDate("fromDate", dateFormat, locale);
        }
        Date toDate = null;
        if (toDateParam != null) {
            toDate = toDateParam.getDate("toDate", dateFormat, locale);
        }

        if (searchParameters == null) {
            searchParameters = SearchParameters.forDateRage(fromDate, toDate);
        } else {
            searchParameters.addFromDate(fromDate);
            searchParameters.addToDate(toDate);
        }

        final Page<VoucherTransactionDTO> voucherTransactions = this.voucherReadService.retrieveAllVoucherTransactions(clientId,
                searchParameters);
        final ApiRequestJsonSerializationSettings settings = this.apiRequestParameterHelper.process(uriInfo.getQueryParameters());

        return this.toApiJsonSerializer.serialize(settings, voucherTransactions);
    }

    @POST
    @Path("create")
    @Consumes({ MediaType.APPLICATION_JSON })
    @Produces({ MediaType.APPLICATION_JSON })
    public String createVoucher(@PathParam("clientId") @Parameter(description = "clientId") final Long clientId,
            final String apiRequestBodyAsJson) {
        final CommandWrapper commandRequest = new CommandWrapperBuilder().createVoucher(clientId).withJson(apiRequestBodyAsJson).build();
        CommandProcessingResult result = this.commandsSourceWritePlatformService.logCommandSource(commandRequest);
        return this.toApiJsonSerializer.serialize(result);
    }

}
