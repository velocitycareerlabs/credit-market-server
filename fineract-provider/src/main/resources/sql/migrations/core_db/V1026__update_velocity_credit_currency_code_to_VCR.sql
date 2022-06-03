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

UPDATE m_currency
SET
code = 'VCR',
internationalized_name_code = 'currency.VCR'
WHERE
code = 'CRD';

UPDATE m_organisation_currency
SET
code = 'VCR',
internationalized_name_code = 'currency.VCR'
WHERE
code = 'CRD';

UPDATE m_savings_product
SET
currency_code = 'VCR';

UPDATE m_savings_account
SET
currency_code = 'VCR';

UPDATE m_account_transfer_transaction
set
currency_code = 'VCR';

UPDATE acc_gl_journal_entry
set
currency_code = 'VCR';

-- The below tables has currency_code but there are no data in those tables in dev
-- updating these table also for safer side

UPDATE m_charge
set
currency_code = 'VCR';

UPDATE m_interest_rate_slab
set
currency_code = 'VCR';

UPDATE m_savings_account_interest_rate_slab
set
currency_code = 'VCR';

UPDATE m_office_transaction
set
currency_code = 'VCR';

UPDATE m_product_loan
set
currency_code = 'VCR';

UPDATE m_cashier_transactions
set
currency_code = 'VCR';

UPDATE m_client_transaction
set
currency_code = 'VCR';

UPDATE m_loanproduct_provisioning_entry
set
currency_code = 'VCR';

UPDATE m_share_product
set
currency_code = 'VCR';