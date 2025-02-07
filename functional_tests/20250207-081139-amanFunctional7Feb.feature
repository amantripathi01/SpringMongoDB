Feature: User Management API Testing

  # User Registration Scenarios
  Scenario: Successful user registration with valid data
    Given the API endpoint "http://api.example.com/v1/users"
    When I send a POST request with payload:
      """
      {
        "username": "testuser1",
        "email": "test@example.com",
        "password": "SecurePass123!"
      }
      """
    Then the response status should be 201
    And the response should contain "user_id"
    And the response should contain "registration_timestamp"

  Scenario: Failed registration with existing email
    Given the API endpoint "http://api.example.com/v1/users"
    When I send a POST request with payload:
      """
      {
        "username": "testuser2",
        "email": "test@example.com",
        "password": "SecurePass123!"
      }
      """
    Then the response status should be 409
    And the response should contain "error": "Email already exists"

  # User Authentication Scenarios
  Scenario: Successful user login
    Given the API endpoint "http://api.example.com/v1/auth/login"
    When I send a POST request with payload:
      """
      {
        "email": "test@example.com",
        "password": "SecurePass123!"
      }
      """
    Then the response status should be 200
    And the response should contain "access_token"
    And the response should contain "refresh_token"

  # User Profile Management Scenarios
  Scenario: Retrieve user profile successfully
    Given the API endpoint "http://api.example.com/v1/users/{user_id}"
    And a valid authentication token
    When I send a GET request
    Then the response status should be 200
    And the response should contain user profile information

  Scenario: Update user profile successfully
    Given the API endpoint "http://api.example.com/v1/users/{user_id}"
    And a valid authentication token
    When I send a PUT request with payload:
      """
      {
        "first_name": "John",
        "last_name": "Doe",
        "phone": "+1234567890"
      }
      """
    Then the response status should be 200
    And the response should contain updated profile information

  # Error Handling Scenarios
  Scenario: Attempt to access protected endpoint without authentication
    Given the API endpoint "http://api.example.com/v1/users/{user_id}"
    When I send a GET request without authentication token
    Then the response status should be 401
    And the response should contain "error": "Authentication required"

  Scenario: Attempt to access non-existent resource
    Given the API endpoint "http://api.example.com/v1/users/999999"
    And a valid authentication token
    When I send a GET request
    Then the response status should be 404
    And the response should contain "error": "User not found"

  # Performance Testing Scenario
  Scenario: Verify API response time for user listing
    Given the API endpoint "http://api.example.com/v1/users"
    And a valid authentication token
    When I send a GET request with query parameters:
      """
      {
        "page": 1,
        "limit": 100
      }
      """
    Then the response status should be 200
    And the response time should be less than 500 milliseconds
    And the response should contain paginated user list

  # Input Validation Scenarios
  Scenario: Attempt registration with invalid email format
    Given the API endpoint "http://api.example.com/v1/users"
    When I send a POST request with payload:
      """
      {
        "username": "testuser3",
        "email": "invalid-email",
        "password": "SecurePass123!"
      }
      """
    Then the response status should be 400
    And the response should contain "error": "Invalid email format"

  # Rate Limiting Scenario
  Scenario: Verify rate limiting functionality
    Given the API endpoint "http://api.example.com/v1/users"
    When I send 100 GET requests within 1 minute
    Then some requests should return status code 429
    And the response should contain "error": "Rate limit exceeded"
