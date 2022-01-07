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
package org.apache.fineract.portfolio.voucher.domain;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "Voucher")
public class Voucher extends AbstractPersistableCustom {

    @Column(name = "client_id")
    private Long clientId;

    @Column(name = "couponBundleId")
    private String couponBundleId;

    @Column(name = "symbol")
    private String symbol;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "used")
    private Integer used;

    @Temporal(TemporalType.DATE)
    @Column(name = "expiry")
    private Date expiryDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updatedAt")
    private Date updatedAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "createdAt")
    private Date createdAt;

    public Long getClientId() {
        return clientId;
    }

    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    public String getCouponBundleId() {
        return couponBundleId;
    }

    public void setCouponBundleId(String couponBundleId) {
        this.couponBundleId = couponBundleId;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getUsed() {
        return used;
    }

    public void setUsed(Integer used) {
        this.used = used;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Voucher() {}

    public Voucher(Long clientId, String couponBundleId, String symbol, Integer quantity, Integer used, Date expiryDate, Date updatedAt,
            Date createdAt) {
        this.clientId = clientId;
        this.couponBundleId = couponBundleId;
        this.symbol = symbol;
        this.quantity = quantity;
        this.used = used;
        this.expiryDate = expiryDate;
        this.updatedAt = updatedAt;
        this.createdAt = createdAt;
    }
}
