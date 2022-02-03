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

-- registrar voucher/transactions perms
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 16, id FROM m_permission where entity_name = 'Voucher';

INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 16, id FROM m_permission where entity_name = 'Voucher_Transaction';

-- fineract admin voucher/transactions perms
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 12, id FROM m_permission where entity_name = 'Voucher';

INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 12, id FROM m_permission where entity_name = 'Voucher_Transaction';

-- system user voucher/transactions perms
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 13, id FROM m_permission where entity_name = 'Voucher' and code LIKE 'READ%';
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 13, id FROM m_permission where entity_name = 'Voucher_Transaction' and code LIKE 'READ%';

-- operations voucher/transactions perms
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 14, id FROM m_permission where entity_name = 'Voucher' and code LIKE 'READ%';
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 14, id FROM m_permission where entity_name = 'Voucher_Transaction' and code LIKE 'READ%';

-- broker voucher/transactions perms
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 15, id FROM m_permission where entity_name = 'Voucher';
INSERT IGNORE INTO `m_role_permission` (`role_id`, `permission_id`)
SELECT 15, id FROM m_permission where entity_name = 'Voucher_Transaction';
