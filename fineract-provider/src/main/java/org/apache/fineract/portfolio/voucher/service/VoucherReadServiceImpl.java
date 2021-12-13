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

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.JdbcSupport;
import org.apache.fineract.infrastructure.core.service.RoutingDataSource;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.portfolio.voucher.data.VoucherBalanceDTO;
import org.apache.fineract.portfolio.voucher.data.VoucherDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

@Service
public class VoucherReadServiceImpl implements VoucherReadService {

    private final JdbcTemplate jdbcTemplate;
    private final PlatformSecurityContext context;

    @Autowired
    public VoucherReadServiceImpl(final PlatformSecurityContext context, final RoutingDataSource dataSource) {
        this.context = context;
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public VoucherBalanceDTO retrieveBalance(final Long clientId) {
        this.context.authenticatedUser();
        final VoucherReadServiceImpl.VoucherBalanceMapper rm = new VoucherReadServiceImpl.VoucherBalanceMapper();
        final String sql = "SELECT sum(`quantity`) balance FROM Voucher where `expiry`  >= NOW() AND `used` =  0 AND `client_id` = ? group by `client_id`";
        return this.jdbcTemplate.queryForObject(sql, rm, new Object[] { clientId });
    }

    @Override
    public List<VoucherDTO> retrieveExpiringInDays(Long clientId, Integer days) {
        this.context.authenticatedUser();
        final VoucherReadServiceImpl.VoucherTransactionMapper rm = new VoucherReadServiceImpl.VoucherTransactionMapper();
        final String sql = "SELECT * FROM Voucher where `expiry`  = DATE_ADD(CURDATE(), INTERVAL ? DAY) AND `used` =  0 AND `client_id` = ?";
        return this.jdbcTemplate.query(sql, rm, new Object[] { days, clientId });
    }

    private static final class VoucherTransactionMapper implements RowMapper<VoucherDTO> {

        @Override
        public VoucherDTO mapRow(final ResultSet rs, @SuppressWarnings("unused") final int rowNum) throws SQLException {
            final Long id = rs.getLong("id");
            final Long clientId = rs.getLong("client_id");
            final String couponBundleId = rs.getString("couponBundleId");
            final String symbol = rs.getString("symbol");
            final Integer quantity = rs.getInt("quantity");
            final LocalDate expiryDate = JdbcSupport.getLocalDate(rs, "expiry");
            final LocalDate at = JdbcSupport.getLocalDate(rs, "at");
            final LocalDate updatedAt = JdbcSupport.getLocalDate(rs, "updatedAt");
            final Boolean used = rs.getBoolean("used");
            return new VoucherDTO(id, clientId, couponBundleId, symbol, quantity, used, expiryDate, at, updatedAt);
        }
    }

    private static final class VoucherBalanceMapper implements RowMapper<VoucherBalanceDTO> {

        @Override
        public VoucherBalanceDTO mapRow(final ResultSet rs, @SuppressWarnings("unused") final int rowNum) throws SQLException {
            final Integer balance = rs.getInt("balance");
            return new VoucherBalanceDTO(balance);
        }
    }
}
