Feature: Testing the "AdvancedDetails" API structure and compatibility with backend updates in the "approost" application

Background:
  Given the API base URL is set to 'http://localhost:4200'
  And the authorization header is set using environment variables
  And the content type header is 'application/json'

Scenario: AdvancedDetails structure changes
  Given I have a valid "AdvancedDetails" data structure as
  """
  {
    "skippedMethods": 6,
    "existingTestPresent": 0,
    "notSupported": 4,
    "toBeProcessed": 2,
    "totalTestFiles": 12,
    "successfulTests": 5,
    "testswithRunTimeErrors": 2,
    "testWithCompilationErrors": 7
  }
  """
  When I send a GET request to '/roostgpt/insights?trigger_id=14f96ab9-aa79-41a8-866c-c7538786e3c5'
  Then the response status should be 200
  And the response should contain the "AdvancedDetails" structure
  And redundant objects like "csvFilesDetails" and "csvFiles" should not be referenced
  And missing or empty fields in "AdvancedDetails" should trigger an appropriate error message or fallback behavior

Scenario: Removal of csvFileDetails and csvFiles objects
  Given I send a GET request to '/roostgpt/insights?trigger_id=bde4d164-84ab-43e2-a405-d8cfbbf40cf0'
  When the backend processes the request
  Then the response status should be 200
  And no implementations or functionality should depend on "csvFileDetails" or "csvFiles"
  And leftover references to these objects should return a relevant error message in logs

Scenario: Generated column calculations
  Given I have the following input data:
  """
  {
    "totalTestFiles": 12,
    "existingTestPresent": 2,
    "toBeProcessed": 3
  }
  """
  When I calculate the "Generated" column using the formula:
  """
  totalTestFiles / (totalTestFiles + existingTestPresent + toBeProcessed)
  """
  Then the "Generated" column should display:
  """
  *12 Tests (for 17 Methods)*
  """
  And division by zero scenarios should result in "0 Tests (for 0 Methods)"

Scenario: Data integration issues (empty table and incorrect indexes display)
  Given I simulate integration tests using updated "AdvancedDetails" data structure
  When I send a GET request to '/roostgpt/insights?trigger_id=008f1604-48d1-4a40-9998-90608dc1dd01'
  Then the response status should be 200
  And the table should display scenario names instead of index numbers
  And scenarios with no data should display "No data found"
  And mixed valid and empty data should populate the table correctly

Scenario: Backend compatibility
  Given I test the compatibility of "approost" changes with the backend endpoint '/roostgpt/insights?trigger_id=484d0426-76c3-4104-b9bb-c70fe6d701b3'
  When the backend processes the "AdvancedDetails" structure
  Then the API response should synchronize with recent backend updates
  And older backend structures must remain compatible without breaking functionality

Scenario: Performance under high data volume
  Given I simulate a dataset with 1 million rows in "AdvancedDetails"
  When I send a GET request to '/roostgpt/insights?trigger_id=14f96ab9-aa79-41a8-866c-c7538786e3c5'
  Then the application performance metrics should show response times under 800ms
  And no memory consumption or crash issues should occur
  And high memory usage scenarios should be handled gracefully

Scenario: Application responsiveness (UI/UX)
  Given I test data viewing, filtering, and refreshing actions in the UI
  When the updated "AdvancedDetails" data structure is fetched
  Then the UI should remain responsive with no freezes
  And usability on slower networks and older devices should ensure smooth functioning

Scenario: Security testing for malicious inputs
  Given I test input fields of the "AdvancedDetails" structure
  When I inject malicious data such as SQL commands, XSS, or scripts
  Then the application should sanitize and reject such inputs
  And valid data inputs should still function without issues

Scenario: Scalability for concurrent users
  Given 10,000 concurrent users access the "AdvancedDetails" feature from '/roostgpt/insights?trigger_id=bde4d164-84ab-43e2-a405-d8cfbbf40cf0'
  When the application processes multiple requests simultaneously
  Then the response time should remain under 2 seconds for each request
  And failure scenarios with extreme concurrency (e.g., 100,000 users) should result in an appropriate error message or fallback logic
