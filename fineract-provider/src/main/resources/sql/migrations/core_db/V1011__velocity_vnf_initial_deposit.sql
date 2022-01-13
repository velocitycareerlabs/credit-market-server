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

INSERT INTO `m_savings_account_transaction` (
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
    (select id from m_savings_account where account_no = '000000001'), '1', NULL, '1', '0', now(), '100000000000.000000',
    NULL, now(), '1', '100000000000.000000',
    '100000000000.000000', now(), '1',
    '0', NULL, '0'
  );

-- Insert accounting entries for this transaction
INSERT INTO `acc_gl_journal_entry` (
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
    '1', '1', NULL, 'CRD', 'S1', NULL,
    '1', NULL, '0', NULL, '0', now(),
    '2', '100000000000.000000', NULL,
    '2', '12', '1', '1', now(),
    now(), '1', '100000000000.000000',
    '100000000000.000000', NULL, NULL,
    NULL
  ),
  (
    '2', '1', NULL, 'CRD', 'S1',
    NULL, '1', NULL, '0', NULL, '0', now(),
    '1', '100000000000.000000', NULL,
    '2', '12', '1', '1', now(),
    now(), '1', '100000000000.000000',
    '100000000000.000000', NULL, NULL,
    NULL
  );


-- update savings account balance
UPDATE
  `m_savings_account`
SET
  `account_balance_derived` = '100000000000'
WHERE
  (`id` = '1');
