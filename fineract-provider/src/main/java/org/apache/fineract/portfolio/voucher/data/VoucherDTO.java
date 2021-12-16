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
package org.apache.fineract.portfolio.voucher.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import java.time.LocalDate;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class VoucherDTO {

    private Long id;
    private Long clientId;
    private String couponBundleId;
    private String symbol;
    private Integer quantity;
    private Integer used;
    private LocalDate expiryDate;
    private LocalDate updatedAt;
    private LocalDate createdAt;
    private Integer balance;

    public VoucherDTO() {}

    public VoucherDTO(Long id, Long clientId, String couponBundleId, String symbol, Integer quantity, Integer used, Integer balance,
            LocalDate expiryDate, LocalDate updatedAt, LocalDate createdAt) {
        this.id = id;
        this.clientId = clientId;
        this.couponBundleId = couponBundleId;
        this.symbol = symbol;
        this.quantity = quantity;
        this.used = used;
        this.balance = balance;
        this.expiryDate = expiryDate;
        this.updatedAt = updatedAt;
        this.createdAt = createdAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getClientId() {
        return clientId;
    }

    public String getCouponBundleId() {
        return couponBundleId;
    }

    public String getSymbol() {
        return symbol;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public Integer getUsed() {
        return used;
    }

    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    public LocalDate getUpdatedAt() {
        return updatedAt;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public Integer getBalance() {
        return balance;
    }

    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    public void setCouponBundleId(String couponBundleId) {
        this.couponBundleId = couponBundleId;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public void setUsed(Integer used) {
        this.used = used;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }

    public void setUpdatedAt(LocalDate updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }
}
