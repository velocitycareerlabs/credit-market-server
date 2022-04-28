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

-- Savings account transaction
INSERT IGNORE INTO `m_savings_account_transaction` (
  `savings_account_id`, `office_id`,
  `payment_detail_id`, `transaction_type_enum`,
  `is_reversed`, `transaction_date`,
  `amount`, `overdraft_amount_derived`,
  `balance_end_date_derived`, `balance_number_of_days_derived`,
  `running_balance_derived`, `cumulative_balance_derived`,
  `created_date`, `appuser_id`, `is_manual`,
  `release_id_of_hold_amount`, `is_loan_disbursement`
)
VALUES
  (
    '1', '1', NULL, '2', '0', now(),
    '60000000000.000000', NULL, now(),
    '1', '40000000000.000000', '40000000000.000000',
    now(), '1', '0',
    NULL, '0'
  ),
  (
    '2', '1', NULL, '1', '0', now(),
    '60000000000.000000', NULL, now(),
    '1', '60000000000.000000', '60000000000.000000',
    now(), '1', '0',
    NULL, '0'
  );


-- transfer details
INSERT IGNORE INTO `m_account_transfer_details`
(`from_office_id`,
`to_office_id`,
`from_client_id`,
`to_client_id`,
`from_savings_account_id`,
`to_savings_account_id`,
`from_loan_account_id`,
`to_loan_account_id`,
`transfer_type`)
VALUES
('1', '1', '1', '2', '1', '2', NULL, NULL, NULL);

-- transfer transaction
INSERT IGNORE INTO `m_account_transfer_transaction` (
  `account_transfer_details_id`, `from_savings_transaction_id`,
  `from_loan_transaction_id`, `to_savings_transaction_id`,
  `to_loan_transaction_id`, `is_reversed`,
  `transaction_date`, `currency_code`,
  `currency_digits`, `currency_multiplesof`,
  `amount`, `description`
)
VALUES
  (
    '1', '2', NULL, '3', NULL, '0', '2022-01-13',
    'CRD', '2', '1', '60000000.000000',
    'VNF to VCL default transfer'
  );

-- journal entries for transfers
INSERT IGNORE INTO `acc_gl_journal_entry` (
  `account_id`, `office_id`, `reversal_id`,
  `currency_code`, `transaction_id`,
  `loan_transaction_id`, `savings_transaction_id`,
  `client_transaction_id`, `reversed`,
  `ref_num`, `manual_entry`, `entry_date`,
  `type_enum`, `amount`, `description`,
  `entity_type_enum`, `entity_id`,
  `createdby_id`, `lastmodifiedby_id`,
  `created_date`, `lastmodified_date`,
  `is_running_balance_calculated`,
  `office_running_balance`, `organization_running_balance`,
  `payment_details_id`, `share_transaction_id`,
  `transaction_date`
)
VALUES
  (
    '2', '1', NULL, 'CRD', 'S2', NULL, '2',
    NULL, '0', NULL, '0', now(), '2', '60000000000.000000',
    NULL, '2', '1', '1', '1', now(), now(),
    '0', '0.000000', '0.000000', NULL,
    NULL, NULL
  ),
  (
    '3', '1', NULL, 'CRD', 'S2', NULL, '2',
    NULL, '0', NULL, '0', now(), '1', '60000000000.000000',
    NULL, '2', '1', '1', '1', now(), now(),
    '0', '0.000000', '0.000000', NULL,
    NULL, NULL
  ),
  (
    '3', '1', NULL, 'CRD', 'S3', NULL, '3',
    NULL, '0', NULL, '0', now(), '2', '60000000000.000000',
    NULL, '2', '2', '1', '1', now(), now(),
    '0', '0.000000', '0.000000', NULL,
    NULL, NULL
  ),
  (
    '2', '1', NULL, 'CRD', 'S3', NULL, '3',
    NULL, '0', NULL, '0', now(), '1', '60000000000.000000',
    NULL, '2', '2', '1', '1', now(), now(),
    '0', '0.000000', '0.000000', NULL,
    NULL, NULL
  );


-- update VNF account balances
UPDATE
  `m_savings_account`
SET
  `account_balance_derived` = '40000000000'
WHERE
  (`id` = '1');

-- update VCL account balances
UPDATE
  `m_savings_account`
SET
  `account_balance_derived` = '60000000000'
WHERE
  (`id` = '2');