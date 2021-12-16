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

INSERT INTO `m_permission`
(`grouping`,
`code`,
`entity_name`,
`action_name`,
`can_maker_checker`)
VALUES
('datatable', 'CREATE_Voucher', 'Voucher', 'CREATE', 1),
('datatable', 'CREATE_Voucher_CHECKER', 'Voucher', 'CREATE', 0),
('datatable', 'READ_Voucher', 'Voucher', 'READ', 0),
('datatable', 'UPDATE_Voucher', 'Voucher', 'UPDATE', 1),
('datatable', 'UPDATE_Voucher_CHECKER', 'Voucher', 'UPDATE', 0),
('datatable', 'DELETE_Voucher', 'Voucher', 'DELETE', 1),
('datatable', 'DELETE_Voucher_CHECKER', 'Voucher', 'DELETE', 0);
