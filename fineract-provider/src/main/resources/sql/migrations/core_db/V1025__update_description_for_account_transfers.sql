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
LEFT  join m_account_transfer_details ac ON ac.id = tr.account_transfer_details_id
LEFT JOIN m_savings_account sa ON sa.id = ac.to_savings_account_id
LEFT JOIN m_savings_product sp ON sp.id = sa.product_id
SET tr.description = CONCAT('STAKE - ', tr.description)
WHERE ac.to_client_id  = ac.from_client_id AND sa.product_id = 2 AND ac.from_savings_account_id > 6;

update m_account_transfer_transaction tr
LEFT  join m_account_transfer_details ac ON ac.id = tr.account_transfer_details_id
SET tr.description = CONCAT('SELL - ', tr.description)
WHERE ac.to_client_id = 6
AND ac.from_client_id = 5;

update m_account_transfer_transaction tr
LEFT  join m_account_transfer_details ac ON ac.id = tr.account_transfer_details_id
SET tr.description = CONCAT('REDEEMVOUCHER - ', tr.description)
WHERE ac.to_client_id = 3
AND ac.from_client_id >= 6;
