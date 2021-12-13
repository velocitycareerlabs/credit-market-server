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

INSERT IGNORE INTO `x_registered_table` (`registered_table_name`, `application_table_name`, `category`)
VALUES ('Voucher_item', 'm_client', 100);

CREATE TABLE IF NOT EXISTS `Voucher_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `couponBundleId` varchar(255) DEFAULT NULL,
  `batch_id` bigint(20) NOT NULL,
  `symbol` varchar(100) DEFAULT NULL,
  `used` bit(1) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_client_id` (`client_id`),
  KEY `fk_batch_id` (`batch_id`),
  CONSTRAINT `fk_voucher_item_client_id` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `fk_voucher_item_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `Voucher` (`id`)
);
