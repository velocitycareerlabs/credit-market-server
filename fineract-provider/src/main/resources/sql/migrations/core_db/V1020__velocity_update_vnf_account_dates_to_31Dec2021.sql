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

UPDATE `m_client`
SET
`submittedon_date` = '2021-12-31',
`activation_date` = '2021-12-31',
`office_joining_date` = '2021-12-31';
WHERE
`id` = 1;

UPDATE `m_savings_account`
SET
`submittedon_date` = '2021-12-31',
`approvedon_date` = '2021-12-31',
`activatedon_date` = '2021-12-31'
WHERE
`id` = 1;

UPDATE `m_savings_account_transaction`
SET
`transaction_date` = '2021-12-31',
`balance_end_date_derived` = '2021-12-31',
`created_date` = '2021-12-31'
WHERE
`id` = 1;

UPDATE `acc_gl_journal_entry`
SET
`entry_date` = '2021-12-31',
`created_date` = '2021-12-31',
`lastmodified_date` = '2021-12-31'
WHERE
`transaction_id` = 'S1';