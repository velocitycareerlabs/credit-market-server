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

-- client entries
INSERT INTO `m_client` (
  `account_no`, `status_enum`, `activation_date`,
  `office_joining_date`, `office_id`,
  `fullname`, `display_name`, `is_staff`,
  `submittedon_date`, `submittedon_userid`,
  `activatedon_userid`,
  `legal_form_enum`
)
VALUES
    (
    '000000003', '300', now(),
    now(), '1', 'VNF Cashier',
    'VNF Cashier', '0', now(),
    '1', '1', '2'
    ),
    (
    '000000004', '300', now(),
    now(), '1', 'VNF Distributer',
    'VNF Distributer', '0', now(),
    '1', '1', '2'
    );

-- saving accounts
INSERT INTO `m_savings_account` (
  `account_no`, `external_id`,
  `client_id`, `group_id`, `gsim_id`,
  `product_id`, `field_officer_id`,
  `status_enum`, `sub_status_enum`,
  `account_type_enum`, `deposit_type_enum`,
  `submittedon_date`, `submittedon_userid`,
  `approvedon_date`, `approvedon_userid`,
  `rejectedon_date`, `rejectedon_userid`,
  `withdrawnon_date`, `withdrawnon_userid`,
  `activatedon_date`, `activatedon_userid`,
  `closedon_date`, `closedon_userid`,
  `currency_code`, `currency_digits`,
  `currency_multiplesof`, `nominal_annual_interest_rate`,
  `interest_compounding_period_enum`,
  `interest_posting_period_enum`,
  `interest_calculation_type_enum`,
  `interest_calculation_days_in_year_type_enum`,
  `min_required_opening_balance`,
  `lockin_period_frequency`, `lockin_period_frequency_enum`,
  `withdrawal_fee_for_transfer`,
  `allow_overdraft`, `overdraft_limit`,
  `nominal_annual_interest_rate_overdraft`,
  `min_overdraft_for_interest_calculation`,
  `lockedin_until_date_derived`,
  `total_deposits_derived`, `total_withdrawals_derived`,
  `total_withdrawal_fees_derived`,
  `total_fees_charge_derived`, `total_penalty_charge_derived`,
  `total_annual_fees_derived`, `total_interest_earned_derived`,
  `total_interest_posted_derived`,
  `total_overdraft_interest_derived`,
  `total_withhold_tax_derived`, `account_balance_derived`,
  `min_required_balance`, `enforce_min_required_balance`,
  `min_balance_for_interest_calculation`,
  `start_interest_calculation_date`,
  `on_hold_funds_derived`, `version`,
  `withhold_tax`, `tax_group_id`,
  `last_interest_calculation_date`,
  `total_savings_amount_on_hold`
)
VALUES
(
    '000000003', NULL, (select id from m_client where fullname = 'VNF Cashier'), NULL,
    NULL, '1', NULL, '300', '0', '1', '100',
    now(), '1', now(),
    '1', NULL, NULL, NULL, NULL, now(),
    '1', NULL, NULL, 'CRD', '2', '1', '0.000000',
    '1', '4', '1', '365', NULL, NULL, NULL,
    '0', '0', '0.000000', '0.000000',
    '0.000000', NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, '0.000000', NULL, '0', NULL,
    NULL, NULL, '2', '0', NULL, NULL, '0.000000'
),
(
    '000000004', NULL, (select id from m_client where fullname = 'VNF Distributer'), NULL,
    NULL, '1', NULL, '300', '0', '1', '100',
    now(), '1', now(),
    '1', NULL, NULL, NULL, NULL, now(),
    '1', NULL, NULL, 'CRD', '2', '1', '0.000000',
    '1', '4', '1', '365', NULL, NULL, NULL,
    '0', '0', '0.000000', '0.000000',
    '0.000000', NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, '0.000000', NULL, '0', NULL,
    NULL, NULL, '2', '0', NULL, NULL, '0.000000'
);


-- link clients with accounts
UPDATE
  `m_client` mc
INNER JOIN `m_savings_account` msa ON msa.`client_id` = mc.id
SET
  `default_savings_account` = msa.id
WHERE
   mc.fullname = 'VNF Cashier';

UPDATE
  `m_client` mc
INNER JOIN `m_savings_account` msa ON msa.`client_id` = mc.id
SET
  `default_savings_account` = msa.id
WHERE
   mc.fullname = 'VNF Distributer';
