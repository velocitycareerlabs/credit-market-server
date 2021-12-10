## API documentation.

## **Authentication**
Fineract APIs are secured and depending on the security options available in fineract, any api request would require some form of authentication and authorization. Checkout this documentation for more information about available authentication protocols.

[<u>https://devcredits.velocitycareerlabs.io/fineract-provider/api-docs/apiLive.htm#authentication_overview</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/api-docs/apiLive.htm#authentication_overview)
NOTE: Dev instance currently uses Basic Authentication and as such base 64 encoded username and password passed in the Authorization headers of any http request should guarantee access/authorization.


**Product configuration**
Products can be created at once from back-office and always fetched/referenced prior to making apis. If there's a strong need to have these APIs, checkout the swagger documentation for creating a savings Product. [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Product/create_13</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Product/create_13)



>API for fetching these products is as also available in the swagger descriptor below [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Product/retrieveAll_34</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Product/retrieveAll_34)
>Request URL: [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/api/v1/savingsproducts</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/api/v1/savingsproducts)
>**Request Method:** GET
>**Authorization:** Basic bWlmb3M6cGFzc3dvcmQ=
>**fineract-platform-tenantid:** default
>**Response**
```json
[
  {
    "id":2,
    "name":"Velocity Credits",
    "shortName":"VCR",
    "description":"This holds Credits",
    "currency":{
      "code":"CRD",
      "name":"Velocity Credits",
      "decimalPlaces":2,
      "inMultiplesOf":1,
      "nameCode":"currency.CRD",
      "displayLabel":"Velocity Credits [CRD]"
    },
    "nominalAnnualInterestRate":0,
    "interestCompoundingPeriodType":{
      "id":1,
      "code":"savings.interest.period.savingsCompoundingInterestPeriodType.daily",
      "value":"Daily"
    },
    "interestPostingPeriodType":{
      "id":4,
      "code":"savings.interest.posting.period.savingsPostingInterestPeriodType.monthly",
      "value":"Monthly"
    },
    "interestCalculationType":{
      "id":1,
      "code":"savingsInterestCalculationType.dailybalance",
      "value":"Daily Balance"
    },
    "interestCalculationDaysInYearType":{
      "id":365,
      "code":"savingsInterestCalculationDaysInYearType.days365",
      "value":"365 Days"
    },
    "withdrawalFeeForTransfers":false,
    "allowOverdraft":false,
    "enforceMinRequiredBalance":false,
    "withHoldTax":false,
    "accountingRule":{
      "id":2,
      "code":"accountingRuleType.cash",
      "value":"CASH BASED"
    },
    "isDormancyTrackingActive":false
  }
]
```
There’s currently two types of products, one is credits (Credits as currency) and the other for coupons (USD as currency).


## **Criteria for testing**
In the use-cases provided below, copy payloads, make minimal recommended changes and post in swagger descriptors to test out the apis. Ensure to also read specific api instructions in swagger descriptors especially concerning mandatory fields and unique ones. Note that some of these examples have already been posted on staging server and will need slight changes like external Id, names to get them to work.
##End to end use-cases

##1.  POST business/organisation

> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Client/create_6</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Client/create_6)
> NOTE: **exernalId**, **fullname** and **MobileNo** are all unique. The
> example already exists in the system so there's a need to change those
> fields to get this to work.
>
> Office id is default 1, legalFormId is 2 for institutions according to
> fineract configurations.
>
> POST /fineract-provider/api/v1/clients HTTP/1.1
> Host: devcredits.velocitycareerlabs.io
> fineract-platform-tenantid: default
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
```json
Payload
{
   "address":[

   ],
   "officeId":1,
   "legalFormId":2,
   "fullname":"Velocity Test Client",
   "mobileNo":"2567897898",
   "externalId":"4F8958D4-7BF3-4730",
   "active":true,
   "locale":"en",
   "dateFormat":"dd MMMM yyyy",
   "activationDate":"12 November 2021",
   "submittedOnDate":"12 November 2021"
}

Response
{
"officeId":1,
"clientId":5,
"resourceId":5
}
```

##2.  Close Client
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Client/activate_1</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Client/activate_1)
>
> 12 is a client id
> Request URL:
> [<u>/fineract-provider/api/v1/clients/12?command=close</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/api/v1/clients/12?command=close)
> Request Method: POST
> Status Code: 200 <br>
> authorization: Basic bWlmb3M6cGFzc3dvcmQ=<br>
> fineract-platform-tenantid: default
```json
Payload
{
   "closureDate":"01 December 2021",
   "closureReasonId":19,
   "locale":"en",
   "dateFormat":"dd MMMM yyyy"
}

Response
{
   "clientId":12,
   "resourceId":12
}
```

##3.  Close Account
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6)
> 8 is savings account Id
> Request URL:
> [<u>/fineract-provider/api/v1/savingsaccounts/8?command=close</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/api/v1/clients/12?command=close)
> Request Method: POST
> Status Code: 200
> authorization: Basic bWlmb3M6cGFzc3dvcmQ=
> fineract-platform-tenantid: default
>
```json
Payload
{
   "postInterestValidationOnClosure":true,
   "closedOnDate":"01 December 2021",
   "withdrawBalance":true,
   "locale":"en",
   "dateFormat":"dd MMMM yyyy",
   "note":"Test",
   "paymentTypeId":2
}

Response
{
   "clientId":12,
   "resourceId":12
}
```

##4.  POST coupons account
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/submitApplication_2</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/submitApplication_2)
> **Note**: product Id for coupons is 1 and it’s in USD
> POST /fineract-provider/api/v1/savingsaccounts HTTP/1.1<br>
> Host: devcredits.velocitycareerlabs.io<br>
> fineract-platform-tenantid: default<br>
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
>
```json
Payload
{
   "productId":1,
   "nominalAnnualInterestRate":0,
   "withdrawalFeeForTransfers":false,
   "allowOverdraft":false,
   "enforceMinRequiredBalance":false,
   "withHoldTax":false,
   "interestCompoundingPeriodType":1,
   "interestPostingPeriodType":4,
   "interestCalculationType":1,
   "interestCalculationDaysInYearType":365,
   "externalId":"VCO-273E-4FF0-A494",
   "submittedOnDate":"12 November 2021",
   "locale":"en",
   "dateFormat":"dd MMMM yyyy",
   "monthDayFormat":"dd MMM",
   "charges":[

   ],
   "clientId":"5"
}

Response
{
   "officeId":1,
   "clientId":5,
   "savingsId":7,
   "resourceId":7,
   "gsimId":0
}
```

##5.  POST credits account
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/submitApplication_2</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/submitApplication_2)
> **Note:** product Id for credits is 2
> POST /fineract-provider/api/v1/savingsaccounts HTTP/1.1
> Host: devcredits.velocitycareerlabs.io
> fineract-platform-tenantid: default
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
```json
Payload
{
    "productId": 2,
    "nominalAnnualInterestRate": 0,
    "withdrawalFeeForTransfers": false,
    "allowOverdraft": false,
    "enforceMinRequiredBalance": false,
    "withHoldTax": false,
    "interestCompoundingPeriodType": 1,
    "interestPostingPeriodType": 4,
    "interestCalculationType": 1,
    "interestCalculationDaysInYearType": 365,
    "externalId": "VCR-273E-4FF0-A494",
    "submittedOnDate": "12 November 2021",
    "locale": "en",
    "dateFormat": "dd MMMM yyyy",
    "monthDayFormat": "dd MMM",
    "charges": [],
    "clientId": "5"
}
Response

{
    "officeId": 1,
    "clientId": 5,
    "savingsId": 8,
    "resourceId": 8,
    "gsimId": 0
}
```
##6.  GET accounts
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/retrieveOne_24</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/retrieveOne_24)
> 8 is the account id, could be coupon or credit
>
> GET
> /fineract-provider/api/v1/savingsaccounts/8?associations=all&pageNumber=1&pageSize=15
> HTTP/1.1<br>
> Host: devcredits.velocitycareerlabs.io<br>
> fineract-platform-tenantid: default<br>
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
>
```json
{
   "id":8,
   "accountNo":"000000008",
   "depositType":{
      "id":100,
      "code":"depositAccountType.savingsDeposit",
      "value":"Savings"
   },
   "externalId":"VCR-273E-4FF0-A494",
   "clientId":5,
   "clientName":"Velocity Test Client",
   "savingsProductId":1,
   "savingsProductName":"Velocity (USD)",
   "fieldOfficerId":0,
   "status":{
      "id":300,
      "code":"savingsAccountStatusType.active",
      "value":"Active",
      "submittedAndPendingApproval":false,
      "approved":false,
      "rejected":false,
      "withdrawnByApplicant":false,
      "active":true,
      "closed":false,
      "prematureClosed":false,
      "transferInProgress":false,
      "transferOnHold":false,
      "matured":false
   },
   "subStatus":{
      "id":0,
      "code":"SavingsAccountSubStatusEnum.none",
      "value":"None",
      "none":true,
      "inactive":false,
      "dormant":false,
      "escheat":false,
      "block":false,
      "blockCredit":false,
      "blockDebit":false
   },
   "timeline":{
      "submittedOnDate":[
         2021,
         11,
         11
      ],
      "submittedByUsername":"mifos",
      "submittedByFirstname":"App",
      "submittedByLastname":"Administrator",
      "approvedOnDate":[
         2021,
         11,
         11
      ],
      "approvedByUsername":"mifos",
      "approvedByFirstname":"App",
      "approvedByLastname":"Administrator",
      "activatedOnDate":[
         2021,
         11,
         11
      ],
      "activatedByUsername":"mifos",
      "activatedByFirstname":"App",
      "activatedByLastname":"Administrator"
   },
   "currency":{
      "code":"USD",
      "name":"US Dollar",
      "decimalPlaces":2,
      "inMultiplesOf":1,
      "displaySymbol":"$",
      "nameCode":"currency.USD",
      "displayLabel":"US Dollar ($)"
   },
   "nominalAnnualInterestRate":0.000000,
   "interestCompoundingPeriodType":{
      "id":1,
      "code":"savings.interest.period.savingsCompoundingInterestPeriodType.daily",
      "value":"Daily"
   },
   "interestPostingPeriodType":{
      "id":4,
      "code":"savings.interest.posting.period.savingsPostingInterestPeriodType.monthly",
      "value":"Monthly"
   },
   "interestCalculationType":{
      "id":1,
      "code":"savingsInterestCalculationType.dailybalance",
      "value":"Daily Balance"
   },
   "interestCalculationDaysInYearType":{
      "id":365,
      "code":"savingsInterestCalculationDaysInYearType.days365",
      "value":"365 Days"
   },
   "withdrawalFeeForTransfers":false,
   "allowOverdraft":false,
   "enforceMinRequiredBalance":false,
   "withHoldTax":false,
   "lastActiveTransactionDate":[
      2021,
      11,
      13
   ],
   "isDormancyTrackingActive":false,
   "summary":{
      "currency":{
         "code":"USD",
         "name":"US Dollar",
         "decimalPlaces":2,
         "inMultiplesOf":1,
         "displaySymbol":"$",
         "nameCode":"currency.USD",
         "displayLabel":"US Dollar ($)"
      },
      "totalDeposits":1000.000000,
      "totalInterestPosted":0,
      "accountBalance":1000.000000,
      "totalOverdraftInterestDerived":0,
      "interestNotPosted":0,
      "availableBalance":1000.000000
   },
   "transactions":[
      {
         "id":68,
         "transactionType":{
            "id":1,
            "code":"savingsAccountTransactionType.deposit",
            "value":"Deposit",
            "deposit":true,
            "dividendPayout":false,
            "withdrawal":false,
            "interestPosting":false,
            "feeDeduction":false,
            "initiateTransfer":false,
            "approveTransfer":false,
            "withdrawTransfer":false,
            "rejectTransfer":false,
            "overdraftInterest":false,
            "writtenoff":false,
            "overdraftFee":true,
            "withholdTax":false,
            "escheat":false,
            "amountHold":false,
            "amountRelease":false
         },
         "accountId":8,
         "accountNo":"000000008",
         "date":[
            2021,
            11,
            13
         ],
         "currency":{
            "code":"USD",
            "name":"US Dollar",
            "decimalPlaces":2,
            "inMultiplesOf":1,
            "displaySymbol":"$",
            "nameCode":"currency.USD",
            "displayLabel":"US Dollar ($)"
         },
         "amount":1000.000000,
         "runningBalance":1000.000000,
         "reversed":false,
         "transfer":{
            "id":3,
            "reversed":false,
            "currency":{
               "code":"USD",
               "name":"US Dollar",
               "decimalPlaces":2,
               "inMultiplesOf":1,
               "displaySymbol":"$",
               "nameCode":"currency.USD",
               "displayLabel":"US Dollar ($)"
            },
            "transferAmount":1000.000000,
            "transferDate":[
               2021,
               11,
               13
            ],
            "transferDescription":"test"
         },
         "submittedOnDate":[
            2021,
            12,
            1
         ],
         "interestedPostedAsOn":false,
         "submittedByUsername":"mifos"
      }
   ]
}

```
>
> Note: this same api has account balances as highlighted in the
> **summary** section of the response as well as the transactions made
> against the account in the **transactions** section.
>
> As for the transactions, the paging query parameters
> *pageNumber=1&pageSize=15* would determine how many transactions are
> fetched.
##7.  Approve Accounts
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6)
>
> POST /fineract-provider/api/v1/savingsaccounts/7?command=approve
> HTTP/1.1
>
> Host: devcredits.velocitycareerlabs.io<br>
> fineract-platform-tenantid: default<br>
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
```json
Payload
{
  "approvedOnDate": "12 November 2021",
  "note": "Approving Coupon",
  "locale": "en",
  "dateFormat": "dd MMMM yyyy"
}

Response
{
  "officeId": 1,
  "clientId": 5,
  "savingsId": 7,
  "resourceId": 7,
  "changes": {
    "status": {
      "id": 200,
      "code": "savingsAccountStatusType.approved",
      "value": "Approved",
      "submittedAndPendingApproval": false,
      "approved": true,
      "rejected": false,
      "withdrawnByApplicant": false,
      "active": false,
      "closed": false,
      "prematureClosed": false,
      "transferInProgress": false,
      "transferOnHold": false,
      "matured": false
    },
    "locale": "en",
    "dateFormat": "dd MMMM yyyy",
    "approvedOnDate": "12 November 2021",
    "note": "Approving Credit"
  }
}

```

##8.  Activate Accounts

> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6)
>
> POST /fineract-provider/api/v1/savingsaccounts/7?command=activate
> HTTP/1.1
>
> Host: devcredits.velocitycareerlabs.io<br>
> fineract-platform-tenantid: default<br>
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
>
```json
Payload
{
    "activatedOnDate": "12 November 2021",
    "locale": "en",
    "dateFormat": "dd MMMM yyyy"
}

Response
{
  "officeId": 1,
  "clientId": 5,
  "savingsId": 7,
  "resourceId": 7,
  "changes": {
    "status": {
      "id": 300,
      "code": "savingsAccountStatusType.active",
      "value": "Active",
      "submittedAndPendingApproval": false,
      "approved": false,
      "rejected": false,
      "withdrawnByApplicant": false,
      "active": true,
      "closed": false,
      "prematureClosed": false,
      "transferInProgress": false,
      "transferOnHold": false,
      "matured": false
    },
    "locale": "en",
    "dateFormat": "dd MMMM yyyy",
    "activatedOnDate": "12 November 2021"
  }
}
```

##9.  Make Transactions
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Savings%20Account/handleCommands_6)**
> **POST
> /fineract-provider/api/v1/savingsaccounts/7/transactions?command=deposit
> HTTP/1.1
>
> Host: devcredits.velocitycareerlabs.io<br>
> fineract-platform-tenantid: default<br>
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
```json
Payload
{
    "transactionDate": "13 November 2021",
    "transactionAmount": "1000",
    "locale": "en",
    "dateFormat": "dd MMMM yyyy"
}

Response
{
"officeId": 1,
"clientId": 5,
"savingsId": 7,
"resourceId": 64,
"changes": {}
}
```
##10. Make Transfers
> Swagger
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Account%20Transfers/create_4</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Account%20Transfers/create_4)
>
> POST /fineract-provider/api/v1/accounttransfers HTTP/1.1<br>
> Host: devcredits.velocitycareerlabs.io<br>
> fineract-platform-tenantid: default<br>
> Authorization: Basic bWlmb3M6cGFzc3dvcmQ=
>
>
```json
Payload
{
    "fromAccountId": "7",
    "fromAccountType": 2,
    "toOfficeId": 1,
    "toAccountType": 2,
    "toClientId": 5,
    "toAccountId": 8,
    "transferAmount": "1000",
    "transferDate": "14 November 2021",
    "transferDescription": "test",
    "locale": "en",
    "dateFormat": "dd MMMM yyyy",
    "fromClientId": 5,
    "fromOfficeId": 1
}

Response
{
    "savingsId": 7,
    "resourceId": 3
}
```

##11. POST/Update Vouchers
> This uses the concept of data tables, check out swagger
> documentation for more details
> [<u>https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Data%20Tables/createDatatableEntry</u>](https://devcredits.velocitycareerlabs.io/fineract-provider/swagger-ui/index.html#/Data%20Tables/createDatatableEntry)

> **
> **With id 3 as the client Id, we can add coupons/vouchers to it in the
> following way
>
> POST
> /fineract-provider/api/v1/datatables/Voucher/3?genericResultSet=true
> Host: devcredits.velocitycareerlabs.io
> Status Code: 200 <br>
> authorization: Basic bWlmb3M6cGFzc3dvcmQ= <br>
> fineract-platform-tenantid: default
>
```json
Payload
{
  "couponBundleId":"edhg-98987-j86990-mder",
  "symbol":"VCC",
  "quantity":"500",
  "used":"false",
  "locale":"en",
  "dateFormat":"dd MMMM yyyy HH:mm",
  "expiry":"24 March 2022 00:00",
  "at":"09 December 2021 12:14",
  "updatedAt":"09 December 2021 12:14"
}

Response
{
  "officeId":1,
  "clientId":3,
  "resourceId":3
}

```
