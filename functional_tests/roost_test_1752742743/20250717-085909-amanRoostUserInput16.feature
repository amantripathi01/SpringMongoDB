Feature: Bank Jerusalem Mobile App API Testing

Background:
  Given the API base URL 'http://api.bankjerusalem.com'
  And the authorization header is set
  And the content type is 'application/json'

Scenario: User Login with Biometric Authentication
  Given the user has biometric authentication set up on their device
  When I send a POST request to '/login/biometric' with the payload:
    """
    {
      "biometricType": "fingerprint",
      "deviceId": "device123"
    }
    """
  Then the response status should be 200
  And the response should contain 'User is successfully logged in and redirected to the account dashboard'

Scenario: View Account Details
  Given the user is logged into the app
  When I send a GET request to '/account/details'
  Then the response status should be 200
  And the response should contain 'account balance'
  And the response should contain 'transaction history for the past 90 days'

Scenario: Transfer Funds to External Account
  Given the user is logged into the app and has sufficient funds
  When I send a POST request to '/transfers/external' with the payload:
    """
    {
      "beneficiary": {
        "name": "John Doe",
        "accountNumber": "123456789",
        "bankCode": "987"
      },
      "amount": 1000,
      "currency": "USD"
    }
    """
  Then the response status should be 201
  And the response should contain 'Funds are successfully transferred to the external account'
  And the user receives a confirmation message

Scenario: System Performance Under Load
  Given the app is accessed by 1000 concurrent users
  When I simulate concurrent logins and transactions
  Then the app's response time should be under 2 seconds for all actions
  And no crashes should occur

Scenario: Security Compliance
  Given the app is deployed in a test environment
  When I check the data transmission
  Then all data transmissions should be encrypted using SSL
  And sensitive data should not be stored in plain text
  And no critical vulnerabilities should be found during the security audit
