Feature: API Testing for User Management System

Background:
  Given the API base URL is set to 'http://localhost:3000'
  And the authorization header is set
  And the content type is 'application/json'

Scenario: User Registration with Valid Details
  Given the registration endpoint '/api/register'
  When I send a POST request with the following payload:
    | username | email           | password  |
    | user123  | user@example.com| Passw0rd! |
  Then the response status should be 201
  And the response should contain a confirmation message
  And a confirmation email is sent to 'user@example.com'

Scenario: Password Reset Functionality
  Given the password reset endpoint '/api/password-reset'
  When I send a POST request with the registered email 'user@example.com'
  Then the response status should be 200
  And the response should contain a message 'Password reset link sent'
  When I receive the password reset link
  And I send a POST request to the link with the new password 'NewPassw0rd!'
  Then the response status should be 200
  And the response should contain a message 'Password successfully changed'
  And the user can log in with the new password

Scenario: Registration Page Load Performance
  Given the registration page URL '/register'
  When I measure the page load time
  Then the page should load within 2 seconds

Scenario: Security Vulnerability Check on Login Page
  Given the login page URL '/login'
  When I perform a security scan using a security testing tool
  Then no SQL injection vulnerabilities should be found
  And no XSS vulnerabilities should be found
  And the application should handle malicious inputs gracefully
