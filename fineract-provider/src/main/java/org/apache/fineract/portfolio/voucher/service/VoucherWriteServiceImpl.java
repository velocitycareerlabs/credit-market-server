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
package org.apache.fineract.portfolio.voucher.service;

import com.google.gson.JsonElement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.ApiParameterError;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResultBuilder;
import org.apache.fineract.infrastructure.core.data.DataValidatorBuilder;
import org.apache.fineract.infrastructure.core.exception.InvalidJsonException;
import org.apache.fineract.infrastructure.core.exception.PlatformApiDataValidationException;
import org.apache.fineract.infrastructure.core.serialization.FromJsonHelper;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.domain.ClientRepositoryWrapper;
import org.apache.fineract.portfolio.voucher.VoucherConstants;
import org.apache.fineract.portfolio.voucher.data.VoucherBalanceDTO;
import org.apache.fineract.portfolio.voucher.data.VoucherDTO;
import org.apache.fineract.portfolio.voucher.domain.Voucher;
import org.apache.fineract.portfolio.voucher.domain.VoucherRepository;
import org.apache.fineract.portfolio.voucher.domain.VoucherTransaction;
import org.apache.fineract.portfolio.voucher.domain.VoucherTransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VoucherWriteServiceImpl implements VoucherWriteService {

    private final PlatformSecurityContext context;
    private final VoucherReadService voucherReadService;
    private final FromJsonHelper fromApiJsonHelper;
    private final VoucherRepository voucherRepository;
    private final VoucherTransactionRepository voucherTransactionRepository;
    private final ClientRepositoryWrapper clientRepository;

    @Autowired
    public VoucherWriteServiceImpl(final PlatformSecurityContext context, final VoucherReadService voucherReadService,
            final FromJsonHelper fromApiJsonHelper, final VoucherRepository voucherRepository,
            final VoucherTransactionRepository voucherTransactionRepository, final ClientRepositoryWrapper clientRepository) {
        this.context = context;
        this.voucherReadService = voucherReadService;
        this.fromApiJsonHelper = fromApiJsonHelper;
        this.voucherRepository = voucherRepository;
        this.voucherTransactionRepository = voucherTransactionRepository;
        this.clientRepository = clientRepository;
    }

    @Override
    public CommandProcessingResult useVoucher(Long clientId, final JsonCommand command) {

        this.context.authenticatedUser();

        final Client clientForUpdate = this.clientRepository.findOneWithNotFoundDetection(clientId);
        this.validate(command);

        final Locale locale = command.extractLocale();
        final DateTimeFormatter fmt = DateTimeFormatter.ofPattern(command.dateFormat()).withLocale(locale);
        final LocalDate sumbittedDate = command.localDateValueOfParameterNamed(VoucherConstants.submittedOnDateParamName);
        final Date expiryDate = Date.from(sumbittedDate.atStartOfDay(DateUtils.getDateTimeZoneOfTenant()).toInstant());

        final Integer requestedVoucherQuantity = command.integerValueOfParameterNamed(VoucherConstants.quantityParamName);
        VoucherBalanceDTO voucherBalance = voucherReadService.retrieveBalance(clientId);
        if (requestedVoucherQuantity.compareTo(voucherBalance.getBalance()) > 0) {
            final ApiParameterError error = ApiParameterError.generalError("requested.amount.cannot.be.greater.than.available.balance",
                    "Requested amount cannot be greater than available balance");
            List<ApiParameterError> errors = new ArrayList<>();
            errors.add(error);
            throw new PlatformApiDataValidationException(errors);
        }

        List<VoucherDTO> availableVouchers = voucherReadService.retrieveExpiringByDate(clientId, expiryDate);
        Integer paidVouchers = 0;
        for (VoucherDTO voucher : availableVouchers) {
            if (paidVouchers.compareTo(requestedVoucherQuantity) == 0) {
                break;
            }

            Integer balanceToPay = requestedVoucherQuantity - paidVouchers;

            // whats available is equal to or more than required to clear request
            if (voucher.getBalance().compareTo(balanceToPay) >= 0) {
                // spend part of or all the voucher balance
                voucher.setUsed(voucher.getUsed() + balanceToPay);
                paidVouchers = paidVouchers + balanceToPay;
                // update voucher bundle
                updateVoucherBundle(voucher.getId(), voucher.getUsed());
            }

            // whats available
            if (voucher.getBalance().compareTo(balanceToPay) < 0) {
                // deplete voucher balance
                voucher.setUsed(voucher.getUsed() + voucher.getBalance());
                paidVouchers = paidVouchers + voucher.getBalance();
                // update voucher bundle
                updateVoucherBundle(voucher.getId(), voucher.getUsed());
            }
        }

        // create voucher transaction
        Date transactionDate = Date.from(sumbittedDate.atStartOfDay(DateUtils.getDateTimeZoneOfTenant()).toInstant());
        VoucherTransaction voucherTransaction = createVoucherTransaction(
                new VoucherTransaction(clientForUpdate.getId(), requestedVoucherQuantity, DateUtils.getDateOfTenant(), transactionDate));

        return new CommandProcessingResultBuilder() //
                .withEntityId(voucherTransaction.getId()) //
                .withClientId(voucherTransaction.getClientId()) //
                .build();
    }

    @Override
    public CommandProcessingResult createVoucher(Long clientId, final JsonCommand command) {

        this.context.authenticatedUser();

        final Client clientForUpdate = this.clientRepository.findOneWithNotFoundDetection(clientId);
        validateVoucher(command);

        final LocalDate expiryDate = command.localDateValueOfParameterNamed(VoucherConstants.expiryDateParamName);
        final Integer quantity = command.integerValueOfParameterNamed(VoucherConstants.quantityParamName);
        final String couponBundleId = command.stringValueOfParameterNamed(VoucherConstants.couponBundleIdParamName);
        final String symbolName = command.stringValueOfParameterNamed(VoucherConstants.symbolParamName);
        Date expiry = Date.from(expiryDate.atStartOfDay(DateUtils.getDateTimeZoneOfTenant()).toInstant());
        Voucher voucher = voucherRepository.saveAndFlush(new Voucher(clientForUpdate.getId(), couponBundleId, symbolName, quantity, 0,
                expiry, DateUtils.getDateOfTenant(), DateUtils.getDateOfTenant()));

        return new CommandProcessingResultBuilder() //
                .withEntityId(voucher.getId()) //
                .withClientId(voucher.getClientId()) //
                .build();
    }

    private void validate(final JsonCommand command) {

        final String json = command.json();
        if (StringUtils.isBlank(json)) {
            throw new InvalidJsonException();
        }

        final List<ApiParameterError> dataValidationErrors = new ArrayList<>();
        final DataValidatorBuilder baseDataValidator = new DataValidatorBuilder(dataValidationErrors)
                .resource(VoucherConstants.VOUCHER_RESOURCE_NAME);

        final JsonElement element = command.parsedJson();

        final LocalDate submittedOnDate = this.fromApiJsonHelper.extractLocalDateNamed(VoucherConstants.submittedOnDateParamName, element);
        baseDataValidator.reset().parameter(VoucherConstants.submittedOnDateParamName).value(submittedOnDate).notNull();

        Integer quantity = this.fromApiJsonHelper.extractIntegerNamed(VoucherConstants.quantityParamName, element, Locale.getDefault());
        baseDataValidator.reset().parameter(VoucherConstants.quantityParamName).value(quantity).notNull().notLessThanMin(1);

        if (!dataValidationErrors.isEmpty()) {
            throw new PlatformApiDataValidationException("validation.msg.validation.errors.exist", "Validation errors exist.",
                    dataValidationErrors);
        }

    }

    private void updateVoucherBundle(Long id, Integer usedVouchers) {
        Voucher voucher = voucherRepository.getById(id);
        voucher.setUsed(usedVouchers);
        voucher.setUpdatedAt(DateUtils.getDateOfTenant());
        voucherRepository.saveAndFlush(voucher);
    }

    private VoucherTransaction createVoucherTransaction(VoucherTransaction voucherTransaction) {
        return voucherTransactionRepository.saveAndFlush(voucherTransaction);
    }

    private void validateVoucher(final JsonCommand command) {

        final String json = command.json();
        if (StringUtils.isBlank(json)) {
            throw new InvalidJsonException();
        }

        final List<ApiParameterError> dataValidationErrors = new ArrayList<>();
        final DataValidatorBuilder baseDataValidator = new DataValidatorBuilder(dataValidationErrors)
                .resource(VoucherConstants.VOUCHER_RESOURCE_NAME);

        final JsonElement element = command.parsedJson();

        Integer quantity = this.fromApiJsonHelper.extractIntegerNamed(VoucherConstants.quantityParamName, element, Locale.getDefault());
        baseDataValidator.reset().parameter(VoucherConstants.quantityParamName).value(quantity).notNull().notLessThanMin(1);

        final LocalDate expiryDate = this.fromApiJsonHelper.extractLocalDateNamed(VoucherConstants.expiryDateParamName, element);
        baseDataValidator.reset().parameter(VoucherConstants.expiryDateParamName).value(expiryDate).notNull();

        final String couponBundleId = this.fromApiJsonHelper.extractStringNamed(VoucherConstants.couponBundleIdParamName, element);
        baseDataValidator.reset().parameter(VoucherConstants.couponBundleIdParamName).value(couponBundleId).notNull();

        final String symbolName = this.fromApiJsonHelper.extractStringNamed(VoucherConstants.symbolParamName, element);
        baseDataValidator.reset().parameter(VoucherConstants.symbolParamName).value(symbolName).notNull();

        final String localName = this.fromApiJsonHelper.extractStringNamed(VoucherConstants.localeParamName, element);
        baseDataValidator.reset().parameter(VoucherConstants.localeParamName).value(localName).notNull();

        final String dateFormat = this.fromApiJsonHelper.extractStringNamed(VoucherConstants.dateFormatParamName, element);
        baseDataValidator.reset().parameter(VoucherConstants.dateFormatParamName).value(dateFormat).notNull();

        if (!dataValidationErrors.isEmpty()) {
            throw new PlatformApiDataValidationException("validation.msg.validation.errors.exist", "Validation errors exist.",
                    dataValidationErrors);
        }

    }
}
