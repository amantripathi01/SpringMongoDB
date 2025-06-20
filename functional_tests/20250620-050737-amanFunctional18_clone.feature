Feature: API Testing for "/country" endpoint

Scenario: Retrieve all countries successfully with valid headers
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier: d645d2b40811f5672c93794d8622da45588f32cdb2ed85336475bf479e5d" and "customer-secret-key: 12546580645c21b8a3529680f455f715b6b6829da8976bdfd2e9d51181fe"
  When I send a GET request to '/country'
  Then the response status should be 200
  And the response body should contain "status: success"
  And the response body should contain "message: Data fetched successfully"
  And the response body should contain an array of countries in "data.countries"

Scenario: Retrieve countries with missing required headers
  Given the API base URL 'http://api.example.com/v1'
  And I send a request without the required headers "app-identifier" or "customer-secret-key"
  When I send a GET request to '/country'
  Then the response status should be 400
  And the response body should contain "status: error"
  And the response body should contain "message: Missing required headers"
  And the response body should contain a description of missing headers in "error_info"

Scenario: Retrieve countries with invalid header values
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier: invalid_value" and "customer-secret-key: invalid_value"
  When I send a GET request to '/country'
  Then the response status should be 401
  And the response body should contain "status: error"
  And the response body should contain "message: Invalid header values"
  And the response body should contain a description of invalid headers in "error_info"

Scenario: Successfully create a new country
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier: d645d2b40811f5672c93794d8622da45588f32cdb2ed85336475bf479e5d" and "customer-secret-key: 12546580645c21b8a3529680f455f715b6b6829da8976bdfd2e9d51181fe"
  And I use the JSON body:
  """
  {
    "name": "INDIA",
    "code": "IND",
    "currencies": ["INR", "USD", "EURO"],
    "default_currency": "INR",
    "is_active": 1
  }
  """
  When I send a POST request to '/country'
  Then the response status should be 201
  And the response body should contain "status: success"
  And the response body should contain "message: Country created successfully"
  And the response body should contain the created country object in "data"

Scenario: Validation error for missing required attributes in country creation
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I use the JSON body:
  """
  {
    "code": "IND"
  }
  """
  When I send a POST request to '/country'
  Then the response status should be 400
  And the response body should contain "status: error"
  And the response body should contain "message: Validation error"
  And the response body should describe validation errors in "error_info"

Scenario: Duplicate country code during creation
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I use the JSON body:
  """
  {
    "name": "Duplicate Country",
    "code": "IND",
    "currencies": ["INR", "USD"],
    "default_currency": "USD",
    "is_active": 1
  }
  """
  When I send a POST request to '/country'
  Then the response status should be 409
  And the response body should contain "status: error"
  And the response body should contain "message: Country code already exists"
  And the response body should describe the conflict in "error_info"

Scenario: Fetch a country successfully by ID
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I set the path parameter "id = 32"
  When I send a GET request to '/country/32'
  Then the response status should be 200
  And the response body should contain "status: success"
  And the response body should contain "message: Data fetched successfully"
  And the response body should contain the country object in "data.country"

Scenario: Fetching a country fails due to non-existent ID
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I set the path parameter "id = 999999"
  When I send a GET request to '/country/999999'
  Then the response status should be 404
  And the response body should contain "status: error"
  And the response body should contain "message: Country with ID not found"
  And the response body should contain "error_info: null"

Scenario: Successfully update a country by ID
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I set the path parameter "id = 32"
  And I use the JSON body:
  """
  {
    "name": "NEW NAME",
    "code": "NEW",
    "currencies": ["USD"],
    "default_currency": "USD",
    "is_active": 1
  }
  """
  When I send a PUT request to '/country/32'
  Then the response status should be 200
  And the response body should contain "status: success"
  And the response body should contain "message: Country updated successfully"
  And the response body should contain the updated country object in "data"

Scenario: Update a country fails due to invalid ID
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I set the path parameter "id = 999999"
  And I use the JSON body:
  """
  {
    "name": "Invalid",
    "code": "INVALID",
    "currencies": ["USD"],
    "default_currency": "USD",
    "is_active": 1
  }
  """
  When I send a PUT request to '/country/999999'
  Then the response status should be 404
  And the response body should contain "status: error"
  And the response body should contain "message: Country ID not found"
  And the response body should contain "error_info: null"

Scenario: Successfully delete a country by ID
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I set the path parameter "id = 32"
  When I send a DELETE request to '/country/32'
  Then the response status should be 200
  And the response body should contain "status: success"
  And the response body should contain "message: Country deleted successfully"
  And the response body should contain "error_info: null"

Scenario: Cannot delete a country that does not exist
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I set the path parameter "id = 999999"
  When I send a DELETE request to '/country/999999'
  Then the response status should be 404
  And the response body should contain "status: error"
  And the response body should contain "message: Country not found to delete"
  And the response body should contain "error_info: null"

Scenario: Test response time for "/country" GET
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I record the time taken for the request
  When I send a GET request to '/country'
  Then the response time should be less than 300ms

Scenario: Perform load testing with high concurrent requests for "/country" GET
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I simulate 500 or more concurrent requests
  When I send GET requests to '/country'
  Then the API should respond consistently without failure or timeout

Scenario: Security testing for authentication on "/country" POST
  Given the API base URL 'http://api.example.com/v1'
  And I attempt to access the endpoint without providing valid bearer token
  When I send a POST request to '/country'
  Then the response status should be 401
  And the response body should contain "status: error"
  And the response body should contain "message: Unauthorized access"
  And the response body should contain "error_info: JWT validation failure"

Scenario: Load testing for "/country/{id}" GET
  Given the API base URL 'http://api.example.com/v1'
  And I use the headers "app-identifier" and "customer-secret-key"
  And I fetch countries by ID repeatedly over 1000 requests
  When I send GET requests to '/country/{id}'
  Then the API should handle the high load efficiently without breaking and producing consistent results
