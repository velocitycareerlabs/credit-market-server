--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements. See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership. The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License. You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
-- KIND, either express or implied. See the License for the
-- specific language governing permissions and limitations
-- under the License.
--

update m_account_transfer_transaction tr
join m_account_transfer_details mctd on mctd.id = tr.account_transfer_details_id
join m_savings_account from_msa on from_msa.id = mctd.from_savings_account_id
join m_client from_mc on from_mc.id = from_msa.client_id
join m_savings_product from_pr on from_pr.id = from_msa.product_id
join m_savings_account to_msa on to_msa.id = mctd.to_savings_account_id
join m_client to_mc on to_mc.id = to_msa.client_id
join m_savings_product to_pr on to_pr.id = to_msa.product_id
set tr.description = CONCAT('ISSUER_ISSUING_REWARD - ', tr.description)
where from_mc.id = 4
and to_mc.fullname = 'Yoti'
and from_pr.id = 1
and to_pr.id = 1;

update m_account_transfer_transaction tr
join m_account_transfer_details mctd on mctd.id = tr.account_transfer_details_id
join m_savings_account from_msa on from_msa.id = mctd.from_savings_account_id
join m_client from_mc on from_mc.id = from_msa.client_id
join m_savings_product from_pr on from_pr.id = from_msa.product_id
join m_savings_account to_msa on to_msa.id = mctd.to_savings_account_id
join m_client to_mc on to_mc.id = to_msa.client_id
join m_savings_product to_pr on to_pr.id = to_msa.product_id
set tr.description = CONCAT('ISSUER_ISSUING_REWARD - ', tr.description)
where from_mc.id = 4
and to_mc.fullname = 'Velocity Career Labs'
and from_pr.id = 1
and to_pr.id = 1
and tr.amount != 13392857.1;

update m_account_transfer_transaction tr
join m_account_transfer_details mctd on mctd.id = tr.account_transfer_details_id
join m_savings_account from_msa on from_msa.id = mctd.from_savings_account_id
join m_client from_mc on from_mc.id = from_msa.client_id
join m_savings_product from_pr on from_pr.id = from_msa.product_id
join m_savings_account to_msa on to_msa.id = mctd.to_savings_account_id
join m_client to_mc on to_mc.id = to_msa.client_id
join m_savings_product to_pr on to_pr.id = to_msa.product_id
set tr.description = CONCAT('NODE_OPERATOR_REWARD - ', tr.description)
where from_mc.id = 4
and to_mc.id > 6
and to_mc.fullname not in ( 'Velocity Career Labs' , 'Yoti')
and from_pr.id = 1
and to_pr.id = 1;

update m_account_transfer_transaction tr
join m_account_transfer_details mctd on mctd.id = tr.account_transfer_details_id
join m_savings_account from_msa on from_msa.id = mctd.from_savings_account_id
join m_client from_mc on from_mc.id = from_msa.client_id
join m_savings_product from_pr on from_pr.id = from_msa.product_id
join m_savings_account to_msa on to_msa.id = mctd.to_savings_account_id
join m_client to_mc on to_mc.id = to_msa.client_id
join m_savings_product to_pr on to_pr.id = to_msa.product_id
set tr.description = CONCAT('NODE_OPERATOR_REWARD - ', tr.description)
where from_mc.id = 4
and to_mc.fullname = 'Velocity Career Labs'
and from_pr.id = 1
and to_pr.id = 1
and tr.amount = 13392857.1;