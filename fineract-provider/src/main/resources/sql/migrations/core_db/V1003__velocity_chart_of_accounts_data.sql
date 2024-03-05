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

INSERT IGNORE INTO `acc_gl_account` (
  `id`, `name`, `parent_id`, `hierarchy`,
  `gl_code`, `disabled`, `manual_journal_entries_allowed`,
  `account_usage`, `classification_enum`,
  `tag_id`, `description`
)
VALUES
(1, 'Savings Asset Reference', NULL, '.', '1', '0', '1', '1', '1', NULL, NULL),
(2, 'Savings Liability Control', NULL, '.', '2', '0', '1', '1', '2', NULL, NULL),
(3, 'Transfers Liability Suspense Account', NULL, '.', '3', '0', '1', '1', '2', NULL, NULL);
