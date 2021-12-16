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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
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
        final String sql = "SELECT sum(`quantity` - `used`) balance FROM Voucher where `expiry`  >= NOW() AND `quantity`>`used` AND `client_id` = ? group by `client_id`";
        return this.jdbcTemplate.queryForObject(sql, rm, new Object[] { clientId });
    }

    @Override
    public List<VoucherDTO> retrieveExpiringInDays(Long clientId, Integer days) {
        this.context.authenticatedUser();
        final VoucherReadServiceImpl.VoucherTransactionMapper rm = new VoucherReadServiceImpl.VoucherTransactionMapper();
        final String sql = "SELECT  `id`, `client_id`, `couponBundleId`, `symbol`, `quantity`, `used`, (`quantity` - `used`) as balance, `expiry`, `updatedAt`, `createdAt`  FROM Voucher where `expiry`  <= DATE_ADD(CURDATE(), INTERVAL ? DAY) AND `used` < `quantity` AND `client_id` = ?";
        return this.jdbcTemplate.query(sql, rm, new Object[] { days, clientId });
    }

    @Override
    public List<VoucherDTO> retrieveExpiringByDate(Long clientId, Date date) {
        this.context.authenticatedUser();
        final StringBuilder sql = new StringBuilder();
        final DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        final List<Object> paramList = new ArrayList<>();

        paramList.add(clientId);

        sql.append(
                "SELECT `id`, `client_id`, `couponBundleId`, `symbol`, `quantity`, `used`, (`quantity` - `used`) as balance, `expiry`, `updatedAt`, `createdAt` FROM Voucher where `used` < `quantity` AND `client_id` = ? ");
        if (date != null) {
            sql.append(" and `expiry` <= ?");

            String dateString = df.format(date);
            paramList.add(dateString);
        }

        sql.append(" ORDER BY DATE(expiry) asc");

        final VoucherReadServiceImpl.VoucherTransactionMapper rm = new VoucherReadServiceImpl.VoucherTransactionMapper();
        return this.jdbcTemplate.query(sql.toString(), rm, paramList.toArray());
    }

    private static final class VoucherTransactionMapper implements RowMapper<VoucherDTO> {

        @Override
        public VoucherDTO mapRow(final ResultSet rs, @SuppressWarnings("unused") final int rowNum) throws SQLException {
            final Long id = rs.getLong("id");
            final Long clientId = rs.getLong("client_id");
            final String couponBundleId = rs.getString("couponBundleId");
            final String symbol = rs.getString("symbol");
            final Integer quantity = rs.getInt("quantity");
            final Integer used = rs.getInt("used");
            final Integer balance = rs.getInt("balance");
            LocalDate expiryDate = JdbcSupport.getLocalDate(rs, "expiry");
            LocalDate updatedAt = JdbcSupport.getLocalDate(rs, "updatedAt");
            LocalDate createdAt = JdbcSupport.getLocalDate(rs, "createdAt");

            return new VoucherDTO(id, clientId, couponBundleId, symbol, quantity, used, balance, expiryDate, updatedAt, createdAt);
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
