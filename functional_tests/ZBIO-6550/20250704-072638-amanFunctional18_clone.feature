Feature: API Testing for Country Endpoints

Background:
  Given the base API URL is 'http://api.example.com/v1'
  And the authorization headers include 'app-identifier' and 'customer-secret-key'
  And the content type is 'application/json'

Scenario: Validate successful retrieval of country list via GET /country
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  When I send a GET request to '/country'
  Then the response status should be 200
  And the response body should include:
    """
    {
      "status": "success",
      "message": "Data fetched successfully",
      "data": {
        "countries": [
          {"id": 32, "name": null, "code": "USA", "default_currency": "USD"}
        ]
      }
    }
    """

Scenario: Validate response when no countries exist via GET /country
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And the database contains no countries
  When I send a GET request to '/country'
  Then the response status should be 200
  And the response body should be:
    """
    {
      "status": "success",
      "message": "Data fetched successfully",
      "data": {
        "countries": []
      }
    }
    """

Scenario: Validate error response for missing headers
  Given I omit 'app-identifier' and 'customer-secret-key' headers
  When I send a GET request to '/country'
  Then the response status should be 401
  And the response body should include:
    """
    {
      "status": "error",
      "message": "Unauthorized access. Missing headers or invalid credentials."
    }
    """

Scenario: Validate successful creation of a country via POST /country
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And I provide body payload:
    """
    {
      "name": "INDIA",
      "code": "IND",
      "currencies": ["INR", "USD", "EURO"],
      "default_currency": "INR",
      "is_active": 1
    }
    """
  When I send a POST request to '/country' with the payload
  Then the response status should be 201
  And the response body should contain:
    """
    {
      "status": "success",
      "message": "Country created successfully",
      "data": {
        "id": 45,
        "name": "INDIA",
        "code": "IND",
        "default_currency": "INR",
        "is_active": 1,
        "currencies": ["INR", "USD", "EURO"]
      }
    }
    """

Scenario: Validate error response for missing mandatory fields via POST /country
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And I provide an incomplete body payload:
    """
    {
      "code": "IND",
      "default_currency": "INR",
      "is_active": 1
    }
    """
  When I send a POST request to '/country' with the incomplete payload
  Then the response status should be 400
  And the response body should include:
    """
    {
      "status": "error",
      "message": "Validation error: 'name' is required."
    }
    """

Scenario: Validate successful retrieval of a country by ID via GET /country/{id}
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And a country with ID 32 exists in the database
  When I send a GET request to '/country/32'
  Then the response status should be 200
  And the response body should include:
    """
    {
      "status": "success",
      "message": "Data fetched successfully",
      "data": {
        "country": {
          "id": 32,
          "name": "USA",
          "code": "USA",
          "default_currency": "USD",
          "is_active": 1
        }
      }
    }
    """

Scenario: Validate error response for invalid country ID via GET /country/{id}
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And no country exists with ID 9999
  When I send a GET request to '/country/9999'
  Then the response status should be 404
  And the response body should include:
    """
    {
      "status": "error",
      "message": "Country not found."
    }
    """

Scenario: Validate successful update of a country via PUT /country/{id}
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And a country with ID 32 exists in the database
  And I provide an update payload:
    """
    {
      "name": "New USA",
      "code": "US",
      "default_currency": "USD",
      "is_active": 0
    }
    """
  When I send a PUT request to '/country/32' with the payload
  Then the response status should be 200
  And the response body should include:
    """
    {
      "status": "success",
      "message": "Country updated successfully",
      "data": {
        "id": 32,
        "name": "New USA",
        "code": "US",
        "default_currency": "USD",
        "is_active": 0
      }
    }
    """

Scenario: Validate error response for invalid data type via PUT /country/{id}
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And I provide an invalid payload:
    """
    {
      "name": "New USA",
      "code": "US",
      "default_currency": "USD",
      "is_active": "string"
    }
    """
  When I send a PUT request to '/country/32' with the invalid payload
  Then the response status should be 400
  And the response body should include:
    """
    {
      "status": "error",
      "message": "Validation error: 'is_active' must be an integer."
    }
    """

Scenario: Validate successful deletion of a country via DELETE /country/{id}
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And a country with ID 32 exists in the database
  When I send a DELETE request to '/country/32'
  Then the response status should be 200
  And the response body should include:
    """
    {
      "status": "success",
      "message": "Country deleted successfully."
    }
    """

Scenario: Validate error response for non-existent ID deletion via DELETE /country/{id}
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And no country exists with ID 9999
  When I send a DELETE request to '/country/9999'
  Then the response status should be 404
  And the response body should include:
    """
    {
      "status": "error",
      "message": "Country not found."
    }
    """

Scenario: Validate API response time under load via GET /country
  Given I have a valid 'app-identifier' and 'customer-secret-key'
  And the database contains 10,000 countries
  When I send a GET request to '/country'
  Then the response time should be less than 500 ms

Scenario: Validate server behavior under stress via multiple concurrent API calls
  Given I send 1000 concurrent requests to the server including GET, POST, PUT, DELETE endpoints
  When the server processes the requests
  Then 99% of the requests should succeed
  And there should be no significant performance degradation

Scenario: Validate endpoint protection against unauthorized access
  Given I omit 'app-identifier' and 'customer-secret-key'
  When I send a POST request to '/country' without proper headers
  Then the response status should be 401
  And the response body should include:
    """
    {
      "status": "error",
      "message": "Unauthorized access. Missing headers or invalid credentials."
    }
    """

Scenario: Validate JWT token protection for POST /country
  Given I provide an incorrect JWT bearer token
  When I send a POST request to '/country'
  Then the response status should be 403
  And the response body should include:
    """
    {
      "status": "error",
      "message": "Forbidden access. Invalid token."
    }
    """

Scenario: Validate proper JSON schema in responses
  Given I send a GET request to any '/country' endpoint
  When I receive the response
  Then the JSON response should follow the documented schema
