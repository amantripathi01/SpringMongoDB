Feature: API Testing for ZBIO-6550 Updates

Background:
Given the API base URL 'http://localhost:4200/roostgpt'
And the authorization header is set to 'Bearer validAuthToken'
And the content type is 'application/json'

Scenario: Validate the updated "advancedDetails" structure with valid input
Given the endpoint '/insights'
And the request payload is
"""
{
  "advancedDetails": {
    "skippedMethods": 6, 
    "existingTestPresent": 0, 
    "notSupported": 4, 
    "toBeProcessed": 2,
    "totalTestFiles": 12,
    "successfulTests": 5,
    "testsWithRunTimeErrors": 2,
    "testsWithCompilationErrors": 7
  }
}
"""
When I send a POST request to '/insights'
Then the response status should be 200
And the response body should contain 
"""
* 12 Test (for 14 methods) *
"""
And the system should correctly display metrics such as 'Generated' column

Scenario: Validate error handling for "advancedDetails" with missing fields
Given the endpoint '/insights'
And the request payload is
"""
{
  "advancedDetails": {
    "skippedMethods": null,
    "existingTestPresent": null
  }
}
"""
When I send a POST request to '/insights'
Then the response status should be 400
And the response should contain an appropriate error message

Scenario: Ensure "csvFileDetails" and "csvFiles" are removed
Given the endpoint '/insights'
When I send a GET request to '/insights'
Then the response status should be 200
And the response body should not contain 'csvFileDetails' or 'csvFiles'

Scenario: Verify index replacement with scenario names in integration tests
Given the endpoint '/integration-tests'
And the request payload is
"""
[
  { "methodName": "Error handling and validation", "status": "successfully_generated" },
  { "methodName": "Bulk operations", "status": "successfully_generated" }
]
"""
When I send a POST request to '/integration-tests'
Then the response status should be 200
And the response should contain the method names as 'Error handling and validation' and 'Bulk operations'
And no indexes such as 1, 2 should be present in the response

Scenario: Test fallback for missing "methodName" in integration tests
Given the endpoint '/integration-tests'
And the request payload is
"""
[
  { "methodName": null, "status": "successfully_generated" }
]
"""
When I send a POST request to '/integration-tests'
Then the response status should be 200
And the response should contain 'Unnamed Scenario' as the fallback name

Scenario: Validate calculations for "advancedDetails" metrics
Given the endpoint '/insights'
And the request payload is
"""
{
  "advancedDetails": {
    "skippedMethods": 6, 
    "existingTestPresent": 0, 
    "notSupported": 4, 
    "toBeProcessed": 2,
    "totalTestFiles": 12
  }
}
"""
When I send a POST request to '/insights'
Then the response status should be 200
And the response body should correctly calculate "totalTests"
And the "Generated" column should display 
"""
12 Test (for 14 Methods)
"""

Scenario: Test for empty "advancedDetails" data handling
Given the endpoint '/insights'
And the request payload is
"""
{ "advancedDetails": {} }
"""
When I send a POST request to '/insights'
Then the response status should be 200
And the response should contain "No data found, please try again later."

Scenario: Performance test for large "advancedDetails" structure
Given the endpoint '/insights'
And the request payload is
"""
{
  "advancedDetails": {
    "skippedMethods": 10000, 
    "existingTestPresent": 5000, 
    "notSupported": 3000, 
    "toBeProcessed": 2000,
    "totalTestFiles": 15000,
    "successfulTests": 8000,
    "testsWithRunTimeErrors": 1000,
    "testsWithCompilationErrors": 6000
  }
}
"""
When I send a POST request to '/insights'
Then the response status should be 200
And the response time should be less than 2 seconds

Scenario: Validate backward compatibility for old vs. new triggers
Given the old trigger endpoint '/insights?trigger_id=484d0426-76c3-4104-b9bb-c70fe6d701b3'
When I send a GET request to '/insights?trigger_id=484d0426-76c3-4104-b9bb-c70fe6d701b3'
Then the response status should be 200
And the application should not break
Given the new trigger endpoint '/insights?trigger_id=14f96ab9-aa79-41a8-866c-c7538786e3c5'
When I send a GET request to '/insights?trigger_id=14f96ab9-aa79-41a8-866c-c7538786e3c5'
Then the response status should be 200
And the application should function seamlessly

Scenario: Ensure UI consistency for updated tables
Given the endpoint '/integration-tests'
And the request payload is
"""
[
  {
    "methodName": "Complete pet store management flow",
    "status": "successfully_generated"
  },
  {
    "methodName": "Bulk operations",
    "status": "successfully_generated"
  }
]
"""
When I send a POST request to '/integration-tests'
Then the response status should be 200
And the UI displays the scenario names properly, including alignment and design

Scenario: Test security validation with invalid authorization token
Given the endpoint '/insights'
And the authorization header is set to 'Bearer invalidAuthToken'
When I send a GET request to '/insights'
Then the response status should be 401
And the response should contain an appropriate error message

Scenario: Load test for integration insights page
Given the endpoint '/insights?trigger_id=868eeb69-5795-4db0-ac7c-27192a8a1e76'
When I send 1000 concurrent GET requests to '/insights?trigger_id=868eeb69-5795-4db0-ac7c-27192a8a1e76'
Then the response status should be 200 for all requests
And the page response time should be less than 2 seconds
