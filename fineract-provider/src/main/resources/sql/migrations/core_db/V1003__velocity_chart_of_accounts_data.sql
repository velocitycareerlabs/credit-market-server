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
-- software d istributed under the License is distributed on an
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
  (
    1, 'Cash and Bank Balances', NULL,
    '.', '10-1-1000', 0, 1, 2, 1, NULL, NULL
  ),
  (
    2, 'Cash at Hand', 1, '.2.', '10-1-1001',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    3, 'Cash at Bank 1', 1, 'null3.', '10-1-1002',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    4, 'Cash at Bank 2', 1, '.4.', '10-1-1003',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    5, 'Cash at Bank 3', 1, '.5.', '10-1-1004',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    6, 'Cash at Bank 4', 1, '.6.', '10-1-1005',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    7, 'Loans Outstanding', NULL, '.',
    '10-1-2000', 0, 1, 2, 1, NULL, NULL
  ),
  (
    8, 'Loans to Females', 7, '.8.', '10-1-2001',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    9, 'Loans to Males', 7, '.9.', '10-1-2002',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    10, 'Loans to Groups', 7, '.10.', '10-1-2003',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    11, 'Loans to Institutions', 7, '.11.',
    '10-1-2004', 0, 1, 1, 1, NULL, NULL
  ),
  (
    12, 'Loans to Others', 7, '.12.', '10-1-2005',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    13, 'Advances', NULL, '.', '10-1-3000',
    0, 1, 2, 1, NULL, NULL
  ),
  (
    14, 'Employee advances', 13, '.14.',
    '10-1-3001', 0, 1, 1, 1, NULL, NULL
  ),
  (
    15, 'Investments', NULL, '.', '10-1-4000',
    0, 1, 2, 1, NULL, NULL
  ),
  (
    16, 'Short Term Investment', 15, '.16.',
    '10-1-4001', 0, 1, 1, 1, NULL, NULL
  ),
  (
    17, 'Long Term Investment', 15, '.17.',
    '10-1-4002', 0, 1, 1, 1, NULL, NULL
  ),
  (
    18, 'Prepayments', NULL, '.', '10-1-5000',
    0, 1, 2, 1, NULL, NULL
  ),
  (
    19, 'Prepaid Rent', 18, '.19.', '10-1-5001',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    20, 'Prepaid Utilities', 18, '.20.',
    '10-1-5002', 0, 1, 1, 1, NULL, NULL
  ),
  (
    21, 'Other Prepayments', 18, '.21.',
    '10-1-5003', 0, 1, 1, 1, NULL, NULL
  ),
  (
    22, 'Receivables', NULL, '.', '10-1-6000',
    0, 1, 2, 1, NULL, NULL
  ),
  (
    23, 'Interest receivable on Loans',
    22, '.23.', '10-1-6001', 0, 1, 1, 1,
    NULL, NULL
  ),
  (
    24, 'Interest receivable on Fixed Deposits',
    22, '.24.', '10-1-6002', 0, 1, 1, 1,
    NULL, NULL
  ),
  (
    25, 'Overdrawn Savings Account',
    22, '.25.', '10-1-6003', 0, 1, 1, 1,
    NULL, NULL
  ),
  (
    26, 'Amounts Receivable from Related Party',
    NULL, '.', '10-1-7000', 0, 1, 2, 1, NULL,
    NULL
  ),
  (
    27, 'Advances to Board\n Members',
    26, '.27.', '10-1-7001', 0, 1, 1, 1,
    NULL, NULL
  ),
  (
    28, 'Other\n receivable from Board Members',
    26, '.28.', '10-1-7002', 0, 1, 1, 1,
    NULL, NULL
  ),
  (
    29, 'Stock', NULL, '.', '10-1-8000',
    0, 1, 2, 1, NULL, NULL
  ),
  (
    30, 'Stock of T-Shirts', 29, '.30.',
    '10-1-8001', 0, 1, 1, 1, NULL, NULL
  ),
  (
    31, 'Stock of Stationery', 29, '.31.',
    '10-1-8002', 0, 1, 1, 1, NULL, NULL
  ),
  (
    32, 'Stock of Other Assets', 29, '.32.',
    '10-1-8003', 0, 1, 1, 1, NULL, NULL
  ),
  (
    33, 'Tangible Assets', NULL, '.', '10-1-9100',
    0, 1, 2, 1, NULL, NULL
  ),
  (
    34, 'Moto Vehicles/Cycles', 33, '.34.',
    '10-1-9101', 0, 1, 1, 1, NULL, NULL
  ),
  (
    35, 'Equipment', 33, '.35.', '10-1-9102',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    36, 'Furniture &\n Fittings', 33,
    '.36.', '10-1-9103', 0, 1, 1, 1, NULL,
    NULL
  ),
  (
    37, 'Computers & Accessories', 33,
    '.37.', '10-1-9104', 0, 1, 1, 1, NULL,
    NULL
  ),
  (
    38, 'Land and Buildings', 33, '.38.',
    '10-1-9105', 0, 1, 1, 1, NULL, NULL
  ),
  (
    39, 'Intangible Assets', NULL, '.',
    '10-1-9200', 0, 1, 2, 1, NULL, NULL
  ),
  (
    40, 'Software', 39, '.40.', '10-1-9201',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    41, 'Goodwill', 39, '.41.', '10-1-9202',
    0, 1, 1, 1, NULL, NULL
  ),
  (
    42, 'Savings and Time deposits',
    NULL, '.', '10-2-1000', 0, 1, 2, 2, NULL,
    NULL
  ),
  (
    43, 'Members\' savings -Females',
    42, '.43.', '10-2-1001', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    44, 'Members\' savings -Males', 42,
    '.44.', '10-2-1002', 0, 1, 1, 2, NULL,
    NULL
  ),
  (
    45, 'Members\'\n savings -Groups',
    42, '.45.', '10-2-1003', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    46, 'Members\' savings -Institutions',
    42, '.46.', '10-2-1004', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    47, 'Members\' savings -Others',
    42, '.47.', '10-2-1005', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    48, 'Interest and Dividends\n Payable',
    NULL, '.', '10-2-2000', 0, 1, 2, 2, NULL,
    NULL
  ),
  (
    49, 'Interest Payable on Savings by Females',
    48, '.49.', '10-2-2001', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    50, 'Dividends Payable to Members',
    48, '.50.', '10-2-2003', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    51, 'Other Accounts Payable and\n Accruals',
    NULL, '.', '10-2-3000', 0, 1, 2, 2, NULL,
    NULL
  ),
  (
    52, 'Interest payable on Borrowed Funds',
    51, '.52.', '10-2-3001', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    53, 'Withholding Tax payable', 51,
    '.53.', '10-2-3002', 0, 1, 1, 2, NULL,
    NULL
  ),
  (
    54, 'Income Tax Liability', 51, '.54.',
    '10-2-3003', 0, 1, 1, 2, NULL, NULL
  ),
  (
    55, 'Professional fees payable',
    51, '.55.', '10-2-3004', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    56, 'Suppliers Payable', 51, '.56.',
    '10-2-3005', 0, 1, 1, 2, NULL, NULL
  ),
  (
    57, 'NSSF payable', 51, '.57.', '10-2-3006',
    0, 1, 1, 2, NULL, NULL
  ),
  (
    58, 'PAYE payable', 51, '.58.', '10-2-3007',
    0, 1, 1, 2, NULL, NULL
  ),
  (
    59, 'Affiliation fees Payable', 51,
    '.59.', '10-2-3008', 0, 1, 1, 2, NULL,
    NULL
  ),
  (
    60, 'Net Salaries/Wages Payable',
    51, '.60.', '10-2-3009', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    61, 'Other Liabilities', NULL, '.',
    '10-2-4000', 0, 1, 2, 2, NULL, NULL
  ),
  (
    62, 'General Loan loss provisions',
    61, '.62.', '10-2-4001', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    63, 'Specific Loan loss provisions',
    61, '.63.', '10-2-4002', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    64, 'Accumulated Depreciation', 61,
    '.64.', '10-2-4003', 0, 1, 1, 2, NULL,
    NULL
  ),
  (
    65, 'Non-Current Liabilities', NULL,
    '.', '10-2-5000', 0, 1, 2, 2, NULL, NULL
  ),
  (
    66, 'Deferred Grant Income', 65, '.66.',
    '10-2-5001', 0, 1, 1, 2, NULL, NULL
  ),
  (
    67, 'Members\' Deposits -Long term Fixed Deposits',
    65, '.67.', '10-2-5002', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    68, 'Long term Debt Market rate',
    65, '.68.', '10-2-5003', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    69, 'Long term Debt Subsidized rate',
    65, '.69.', '10-2-5004', 0, 1, 1, 2,
    NULL, NULL
  ),
  (
    70, 'Member Share', NULL, '.', '10-3-1000',
    0, 1, 2, 3, NULL, NULL
  ),
  (
    71, 'Shares Class 1', 70, '.71.', '10-3-1001',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    72, 'Shares Class 2', 70, '.72.', '10-3-1002',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    73, 'Shares Class 3', 70, '.73.', '10-3-1003',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    74, 'Statutory Reset', NULL, '.', '10-3-2000',
    0, 1, 2, 3, NULL, NULL
  ),
  (
    75, 'Reserve Fund', 74, '.75.', '10-3-2001',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    76, 'Share Transfer Fund', 74, '.76.',
    '10-3-2002', 0, 1, 1, 3, NULL, NULL
  ),
  (
    77, 'Retained Earnings', NULL, '.',
    '10-3-3000', 0, 1, 2, 3, NULL, NULL
  ),
  (
    78, 'Retained Profit', 77, '.78.',
    '10-3-3001', 0, 1, 1, 3, NULL, NULL
  ),
  (
    79, 'Current Year Profit', 77, '.79.',
    '10-3-3002', 0, 1, 1, 3, NULL, NULL
  ),
  (
    80, 'Capital Grant (Donated Equity)',
    NULL, '.', '10-3-4000', 0, 1, 2, 3, NULL,
    NULL
  ),
  (
    81, 'Donor 1', 80, '.81.', '10-3-4001',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    82, 'Donor 2', 80, '.82.', '10-3-4002',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    83, 'Donor 3', 80, '.83.', '10-3-4003',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    84, 'Other Donors', 80, '.84.', '10-3-4004',
    0, 1, 1, 3, NULL, NULL
  ),
  (
    85, 'Loans Income', NULL, '.', '10-4-1000',
    0, 1, 2, 4, NULL, NULL
  ),
  (
    86, 'Interest income on Loans', 85,
    'null86.', '10-4-1001', 0, 1, 1, 4,
    NULL, NULL
  ),
  (
    87, 'Commision on Loans', 85, '.87.',
    '10-4-1002', 0, 1, 1, 4, NULL, NULL
  ),
  (
    88, 'Penalty and Surcharge', 85, '.88.',
    '10-4-1003', 0, 1, 1, 4, NULL, NULL
  ),
  (
    89, 'Other Loans Income', 85, '.89.',
    '10-4-1004', 0, 1, 1, 4, NULL, NULL
  ),
  (
    90, 'Saving and Membership fees Income',
    NULL, '.', '10-4-2000', 0, 1, 2, 4, NULL,
    NULL
  ),
  (
    91, 'Membership Fees', 90, '.91.',
    '10-4-2001', 0, 1, 1, 4, NULL, NULL
  ),
  (
    92, 'Entrance Fees', 90, '.92.', '10-4-2002',
    0, 1, 1, 4, NULL, NULL
  ),
  (
    93, 'Sale of Stationery', 90, '.93.',
    '10-4-2003', 0, 1, 1, 4, NULL, NULL
  ),
  (
    94, 'Saving Ledger Fees', 90, '.94.',
    '10-4-2004', 0, 1, 1, 4, NULL, NULL
  ),
  (
    95, 'Account Closure Fees', 90, '.95.',
    '10-4-2005', 0, 1, 1, 4, NULL, NULL
  ),
  (
    96, 'Grant Income', NULL, '.', '10-4-3000',
    0, 1, 2, 4, NULL, NULL
  ),
  (
    97, 'Grant Income for Loan Capital',
    96, '.97.', '10-4-3001', 0, 1, 1, 4,
    NULL, NULL
  ),
  (
    98, 'Grant Income for Operations',
    96, '.98.', '10-4-3002', 0, 1, 1, 4,
    NULL, NULL
  ),
  (
    99, 'Investments Income', NULL, '.',
    '10-4-4000', 0, 1, 2, 4, NULL, NULL
  ),
  (
    100, 'Interest on Fixed Deposits',
    99, '.100.', '10-4-4001', 0, 1, 1, 4,
    NULL, NULL
  ),
  (
    101, 'Other Investment Income', 99,
    '.101.', '10-4-4002', 0, 1, 1, 4, NULL,
    NULL
  ),
  (
    102, 'Other Income', NULL, '.', '10-4-5000',
    0, 1, 2, 4, NULL, NULL
  ),
  (
    103, 'Recovery of Loan previously written off',
    102, '.103.', '10-4-5001', 0, 1, 1,
    4, NULL, NULL
  ),
  (
    104, 'Interest from Bank A/C', 102,
    '.104.', '10-4-5002', 0, 1, 1, 4, NULL,
    NULL
  ),
  (
    105, 'Profit on Sale of Fixed Assets',
    102, '.105.', '10-4-5003', 0, 1, 1,
    4, NULL, NULL
  ),
  (
    106, 'Foreign Exchange gain', 102,
    '.106.', '10-4-5004', 0, 1, 1, 4, NULL,
    NULL
  ),
  (
    107, 'Miscellaneous Income', 102,
    '.107.', '10-4-5005', 0, 1, 1, 4, NULL,
    NULL
  ),
  (
    108, 'Financial Costs', NULL, '.',
    '10-5-1000', 0, 1, 2, 5, NULL, NULL
  ),
  (
    109, 'Interest Expense on Member\'s Savings',
    108, '.109.', '10-5-1001', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    110, 'Interest Expense on Borrowed Funds',
    108, '.110.', '10-5-1002', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    111, 'Interest Expense on Time Deposit',
    108, '.111.', '10-5-1003', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    112, 'Other Financial Costs', 108,
    '.112.', '10-5-1004', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    113, 'Direct Loan Cost', NULL, '.',
    '10-5-2000', 0, 1, 2, 5, NULL, NULL
  ),
  (
    114, 'Bad Debts Expense', 113, '.114.',
    '10-5-2001', 0, 1, 1, 5, NULL, NULL
  ),
  (
    115, 'Loan Appraisal Cost', 113, '.115.',
    '10-5-2002', 0, 1, 1, 5, NULL, NULL
  ),
  (
    116, 'Loan Monitoring and Recovery Cost',
    113, '.116.', '10-5-2003', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    117, 'Legal Fees on Loans', 113, '.117.',
    '10-5-2004', 0, 1, 1, 5, NULL, NULL
  ),
  (
    118, 'Other Direct Loan Costs', 113,
    '.118.', '10-5-2005', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    119, 'Staff Costs', NULL, '.', '10-5-3000',
    0, 1, 2, 5, NULL, NULL
  ),
  (
    120, 'Gross Salaries', 119, '.120.',
    '10-5-3001', 0, 1, 1, 5, NULL, NULL
  ),
  (
    121, 'Staff welfare and incentives',
    119, '.121.', '10-5-3002', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    122, 'NSSF - 10%', 119, '.122.', '10-5-3003',
    0, 1, 1, 5, NULL, NULL
  ),
  (
    123, 'Gratuity', 119, '.123.', '10-5-3004',
    0, 1, 1, 5, NULL, NULL
  ),
  (
    124, 'Staff training, workshops & capacity building',
    119, '.124.', '10-5-3005', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    125, 'Other Personnel Expenses',
    119, '.125.', '10-5-3006', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    126, 'Administration Expenses', NULL,
    '.', '10-5-4000', 0, 1, 2, 5, NULL, NULL
  ),
  (
    127, 'Stationery Expenses', 126,
    '.127.', '10-5-4001', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    128, 'Rent of Office Premises', 126,
    '.128.', '10-5-4002', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    129, 'Office Expenses', 126, '.129.',
    '10-5-4003', 0, 1, 1, 5, NULL, NULL
  ),
  (
    130, 'Telephone', 126, '.130.', '10-5-4004',
    0, 1, 1, 5, NULL, NULL
  ),
  (
    131, 'Internet and E-mail', 126, '.131.',
    '10-5-4005', 0, 1, 1, 5, NULL, NULL
  ),
  (
    132, 'Professional Fees', 126, '.132.',
    '10-5-4006', 0, 1, 1, 5, NULL, NULL
  ),
  (
    133, 'Transport and Travels', 126,
    '.133.', '10-5-4007', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    134, 'Adverts, annoucements and publicity',
    126, '.134.', '10-5-4008', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    135, 'Power/fuel Costs', 126, '.135.',
    '10-5-4009', 0, 1, 1, 5, NULL, NULL
  ),
  (
    136, 'Accomodation Allowances', 126,
    '.136.', '10-5-4100', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    137, 'Duty Allowances', 126, '.137.',
    '10-5-4101', 0, 1, 1, 5, NULL, NULL
  ),
  (
    138, 'Community Mobilisation',
    126, '.138.', '10-5-4102', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    139, 'Audit Cost & Legal Fees', 126,
    '.139.', '10-5-4103', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    140, 'Depreciation', 126, '.140.',
    '10-5-4104', 0, 1, 1, 5, NULL, NULL
  ),
  (
    141, 'Loss on Sale of Fixed Assets',
    126, '.141.', '10-5-4105', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    142, 'Equipment Repairs & Replacement',
    126, '.142.', '10-5-4106', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    143, 'Security Expenses', 126, '.143.',
    '10-5-4107', 0, 1, 1, 5, NULL, NULL
  ),
  (
    144, 'Computer Expenses', 126, '.144.',
    '10-5-4108', 0, 1, 1, 5, NULL, NULL
  ),
  (
    145, 'Donations and Gifts', 126, '.145.',
    '10-5-4109', 0, 1, 1, 5, NULL, NULL
  ),
  (
    146, 'Bank Charges', 126, '.146.',
    '10-5-4020', 0, 1, 1, 5, NULL, NULL
  ),
  (
    147, 'Affiliation Fees Expense',
    126, '.147.', '10-5-4021', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    148, 'Miscellaneous Administrative Expenses',
    126, '.148.', '10-5-4022', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    149, 'Governance Expenses', NULL,
    '.', '10-5-5000', 0, 1, 2, 5, NULL, NULL
  ),
  (
    150, 'General Meeting Expenses',
    149, '.150.', '10-5-5001', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    151, 'Registration Fees', 149, '.151.',
    '10-5-5002', 0, 1, 1, 5, NULL, NULL
  ),
  (
    152, 'Committee Expenses', 149,
    '.152.', '10-5-5003', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    153, 'Other Governance Expenses',
    149, '.153.', '10-5-5004', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    154, 'Statutory Expenses', NULL, '.',
    '10-5-6000', 0, 1, 2, 5, NULL, NULL
  ),
  (
    155, 'Cooperative Development Fund Contribution',
    154, '.155.', '10-5-6001', 0, 1, 1,
    5, NULL, NULL
  ),
  (
    156, 'Members\' Training', 154,
    '.156.', '10-5-6002', 0, 1, 1, 5, NULL,
    NULL
  ),
  (
    157, 'Education Fund', 154, '.157.',
    '10-5-6003', 0, 1, 1, 5, NULL, NULL
  ),
  (
    158, 'Other Statutory Expenses',
    154, '.158.', '10-5-6004', 0, 1, 1,
    5, NULL, NULL
  );
