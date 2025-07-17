Feature: Akitra Compliance API Testing

Background:
  Given the API base URL 'https://api.akitra.net'
  And the authorization header is set with a valid token
  And the content type is 'application/json'

Scenario: Account Creation with Admin Role
  Given the endpoint '/accounts/create'
  And the request payload is:
    """
    {
      "email": "admin@example.com",
      "password": "SecurePass123",
      "role": "admin"
    }
    """
  When I send a POST request to the endpoint
  Then the response status should be 201
  And the response body should contain 'account created successfully'
  And the user role should be 'admin'

Scenario: Add Compliance Coordinator User
  Given the endpoint '/users/add'
  And the request payload is:
    """
    {
      "email": "coordinator@example.com",
      "role": "Compliance Coordinator"
    }
    """
  When I send a POST request to the endpoint
  Then the response status should be 200
  And the response body should contain 'user added successfully'
  And the user role should be 'Compliance Coordinator'

Scenario: Configure Integration with Cloud Platform
  Given the endpoint '/integrations/configure'
  And the request payload is:
    """
    {
      "platform": "AWS",
      "credentials": {
        "accessKey": "AKIA...",
        "secretKey": "abc123..."
      }
    }
    """
  When I send a POST request to the endpoint
  Then the response status should be 200
  And the response body should contain 'integration configured successfully'
  And evidence collection should be enabled

Scenario: Performance of Evidence Collection
  Given the endpoint '/evidence/collect'
  When I send a GET request to the endpoint
  Then the response status should be 200
  And the evidence should be collected within 5 minutes

Scenario: Policy Management Customization
  Given the endpoint '/policies/edit'
  And the request payload is:
    """
    {
      "policyId": "12345",
      "changes": {
        "title": "Updated Policy Title",
        "content": "Updated policy content to match company operations."
      }
    }
    """
  When I send a PUT request to the endpoint
  Then the response status should be 200
  And the response body should contain 'policy updated successfully'
  And the changes should reflect in the system

Scenario: System Usability Assessment
  Given access to the Akitra Compliance console
  When I perform tasks such as account creation, user management, and policy customization
  Then the interface should be intuitive and easy to navigate
  And minimal training should be required for new users
